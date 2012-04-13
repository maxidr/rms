# coding: utf-8
class RequerimientosController < ApplicationController

	respond_to :html, :xml, :json
	respond_to :js, :only => [:motivo_rechazo, :motivo_rechazo_compras]
	respond_to :pdf, :only => [:show]

	before_filter :authenticate_usuario!
	# IMPROVE: Utilizar el método de cancan load_and_authorize_resource (https://github.com/ryanb/cancan/wiki/authorizing-controller-actions)
	before_filter :obtener_rqm, :only => [:edit, :solicitar_aprobacion, :check_state, :show, :update, :aprobar, :motivo_rechazo, :rechazar, :solicitar_aprobacion_compras, :motivo_rechazo_compras, :rechazar_por_compras, :recepcionar, :verificar_entrega, :finalizar, :motivo_rechazo_entrega, :rechazar_entrega]
	before_filter :check_state, :only => [:edit, :update]
	before_filter :puede_aprobar_por_sector, :only => [:rechazar, :aprobar, :motivo_rechazo]

	def finalizar
		authorize! :finalizar, @requerimiento
		respond_with @requerimiento do |format|
			if @requerimiento.finalizar! current_usuario
				flash[:notice] = "El requerimiento fue finalizado con éxito."
			end
			format.html{ render :show }
		end
	end

	# PUT /requerimientos/{id}/
	def rechazar_entrega
		authorize! :rechazar_entrega, @requerimiento
		logger.debug "Se rechaza la entrega del requerimiento: #{@requerimiento}"
		@rechazo = DetalleRechazoEntrega.new(params[:detalle_rechazo_entrega])
		@rechazo.rechazado_por = current_usuario
		respond_with @requerimiento  do |format|
			if @requerimiento.rechazar_entrega! @rechazo
				format.html { redirect_to @requerimiento }
			else
				# Error en rechazar_entrega!
				format.html { render :motivo_rechazo_entrega }
			end
		end
	end

	# GET /requerimientos/{id}/rechazar_entrega
	# Retorna la pantalla que permite cargar el motivo del rechazo de la entrega de materiales
	def motivo_rechazo_entrega
		@rechazo = DetalleRechazoEntrega.new
	end

	def verificar_entrega
		authorize! :verificar_entrega, @requerimiento
		respond_with @requerimiento do |format|
			if @requerimiento.verificar_entrega!
				flash[:notice] = "La entrega de los materiales del requerimiento fue verificada y es correcta."
			end
			format.html{ render :show }
		end
	end

	def recepcionar
		logger.debug "Recepcionar requerimiento"
		authorize! :recepcionar, @requerimiento
		respond_with @requerimiento do |format|
			if @requerimiento.recepcionar!(current_usuario)
				flash[:notice] = "Se recepcionaron los materiales del requerimiento"
			end
			format.html{ render :show	}
		end
	end

	def comprar
		@compra = Compra.new(params[:compra])
		logger.debug("Se confirma la compra del requerimiento n° #{@compra.requerimiento.id}")
		logger.debug("Fecha probable de compra: #{@compra.fecha_probable_entrega}")
		@requerimiento = @compra.requerimiento
		@compra.presupuesto = @requerimiento.presupuestos.aprobado
		respond_with @compra, :location => @requerimiento  do |format|
			#	FIXME: Esta parte debería ser una transacción
			if @compra.save
				@requerimiento.realizar_compra!(@compra)
				flash[:notice] = "Se confirmó la compra con fecha probable de entrega al #{localize @compra.fecha_probable_entrega}"
			else
				format.html{ render :show }
			end
		end
	end

	# PUT /requerimientos/{id}/rechazar/presupuestos
	def rechazar_por_compras
		authorize! :rechazar_por_compras, @requerimiento
		motivo = params[:rechazo][:motivo]
		respond_with @requerimiento do |format|
			if motivo.blank?
				flash[:error] = "Debe especificar un motivo para el rechazo"
				format.html { render :motivo_rechazo_compras }
			elsif @requerimiento.rechazar_por_compras!(motivo, current_usuario)
				flash[:notice] = "Se rechazó el requerimiento"
				format.html { redirect_to @requerimiento }
			else
				format.html { render :motivo_rechazo_compras }
			end
		end
	end

	# GET /requerimientos/{id}/rechazar/presupuestos
	# Retorna la pantalla que permite cargar el motivo del rechazo del requerimiento por parte del sector de compras
	def motivo_rechazo_compras
	end

	def solicitar_aprobacion_compras
		authorize! :solicitar_aprobacion_compras, @requerimiento
		if @requerimiento.solicitar_aprobacion_compras!
			flash[:notice] = "Se envió la solicitud al sector de compras"
			respond_with @requerimiento
		else
			respond_with @requerimiento.errors, :status => :unprocessable_entity do |format|
				format.html{ render :show }
			end
		end
	end

	# Solicitar aprobación del sector
	def solicitar_aprobacion
		logger.debug("Se desea solicitar aprobacion del requerimiento #{@requerimiento.id}")
		authorize! :solicitar_aprobacion, @requerimiento
#		if cannot? :solicitar_aprobacion, @requerimiento
#			logger.debug("No puede solicitar la aprobación del sector para este requerimiento")
#			flash[:error] = "No puede solicitar la aprobación del sector para este requerimiento"
#			respond_with "No puede", :status => :unprocessable_entity
#			respond_with(@requerimiento, :status => :unprocessable_entity) do |format|
#				format.html { render :action => "show" }
#				format.xml  { render :xml => flash[:error], :status => :unprocessable_entity }
#			end

			respond_to do |format|
				if @requerimiento.solicitar_aprobacion_sector!
					format.html { redirect_to(@requerimiento, :notice => "Se solicitó la aprobación del requerimiento al responsable del sector.") }
		      format.xml  { head :ok }
				else
					format.html { render :action => "show" }
		      format.xml  { render :xml => @requerimiento.errors, :status => :unprocessable_entity }
				end
			end

	end

	# PUT /requerimientos/{id}/aprobar
	def aprobar
		logger.debug("Se aprueba el requerimiento")
		if @requerimiento.aprobar_por_sector! current_usuario
			flash[:notice] = "Se autorizó el requerimiento"
			respond_with @requerimiento
		else
			respond_with @requerimiento.errors, :status => :unprocessable_entity do |format|
				format.html{ render :show }
			end
		end
	end

	# PUT /requerimientos/{id}/rechazar
	def rechazar
		logger.debug("Se rechaza el requerimiento")
		logger.debug(params[:rechazo])
		if @requerimiento.rechazar_por_sector!( params[:rechazo][:motivo], current_usuario )
			flash[:notice] = "Se rechazó el requerimiento y se envió un email al solicitante"
			respond_with @requerimiento, :location => @requerimiento
		else
			respond_with @requerimiento.errors, :status => :unprocessable_entity do |format|
				format.html{ render :motivo_rechazo }
			end
		end
	end

	# GET /requerimientos/{id}/rechazar
	# IMPROVE: Modificar método a motivo_rechazo_sector (cambiar vista y ruteo)
	# TODO: Realizar esta tarea con una ventana modal (ajax)
	def motivo_rechazo
	end

  def index
#    @requerimientos = Requerimiento.where(:solicitante_id => current_usuario)
		#	FIXME: El usuario puede ver sus requerimientos y los que debe autorizar
		@search = Requerimiento.para_usuario(current_usuario)
      .joins(:empresa, :solicitante, :sector, :rubro)
      .search(search_params('id.desc'))
		respond_with @requerimientos = @search.paginate(:page => params[:page], :per_page => 15)

#		respond_with( @requerimientos = Requerimiento.includes(:solicitante, :empresa, :sector, :rubro).all )
  end

  def show
#   	respond_with @requerimiento do |format|
#   	  format.pdf{ render :pdf => "requerimiento.pdf" }
#   	end

   	respond_to do |format|
      format.html
      format.pdf do
          render :pdf => "requerimiento_#{@requerimiento.id}",
                 :template => 'reportes/show.pdf.slim',
                 :show_as_html => params[:debug].present?,      # allow debuging based on url param
                 :layout => 'pdf.html.erb',
                 :footer => {
                    :right => "Reporte generado el #{l DateTime.current}"
                 }
      end
    end
  end

  # GET /requerimientos/new
  # GET /requerimientos/new.xml
  def new
    @requerimiento = Requerimiento.new
    @requerimiento.solicitante = current_usuario
    respond_with @requerimiento
  end

  # GET /requerimientos/1/edit
  def edit
  end

  # POST /requerimientos
  # POST /requerimientos.xml
  def create
    @requerimiento = Requerimiento.new(params[:requerimiento])
    @requerimiento.solicitante = current_usuario
    if @requerimiento.save
    	respond_with @requerimiento, :status => :created, :location => new_requerimiento_material_url(@requerimiento)
    else
    	respond_with @requerimiento.errors, :status => :unprocessable_entity do |format|
    		format.html{ render :new }
    	end
    end

#    respond_to do |format|
#      if @requerimiento.save
#
#        format.html { redirect_to new_requerimiento_material_url(@requerimiento) }
#        format.xml  { render :xml => @requerimiento, :status => :created, :location => @requerimiento }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @requerimiento.errors, :status => :unprocessable_entity }
#      end
#    end
  end

  # PUT /requerimientos/1
  # PUT /requerimientos/1.xml
  def update
    respond_to do |format|
      if @requerimiento.update_attributes(params[:requerimiento])
        format.html { redirect_to(@requerimiento, :notice => 'Requerimiento actualizado.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @requerimiento.errors, :status => :unprocessable_entity }
      end
    end
  end



  # DELETE /requerimientos/1
  # DELETE /requerimientos/1.xml
  def destroy
    @requerimiento = Requerimiento.find(params[:id])
    @requerimiento.destroy
    respond_to do |format|
      format.html { redirect_to(requerimientos_url) }
      format.xml  { head :ok }
    end
  end

	private

		def obtener_rqm
			@requerimiento = Requerimiento.find(params[:id])
		end

		def check_state
		  if cannot? :edit, @requerimiento
		  	@requerimiento.errors[:base] = 'El requerimiento no puede ser modificado hasta que no cambie de estado'
		  	render :action => :show
		  end
		end

		def puede_aprobar_por_sector
			authorize! :aprobar_por_sector, @requerimiento
		end

end

