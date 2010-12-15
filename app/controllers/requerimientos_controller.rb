# coding: utf-8
class RequerimientosController < ApplicationController

	respond_to :html, :xml, :json

	before_filter :authenticate_usuario!
	before_filter :obtener_rqm, :only => [:edit, :solicitar_aprobacion, :check_state, :show, :update, :aprobar, :motivo_rechazo, :rechazar]
	before_filter :check_state, :only => [:edit, :update]
	before_filter :puede_aprobar_por_sector, :only => [:rechazar, :aprobar, :motivo_rechazo] 


	def solicitar_aprobacion
		logger.debug("Se desea solicitar aprobacion del requerimiento #{@requerimiento.id}")
		respond_to do |format|
			if @requerimiento.solicitar_aprobacion_sector!
				responsable = @requerimiento.sector.responsable
				format.html { redirect_to(@requerimiento,
					:notice => "Se solicitó la aprobación del requerimiento a #{responsable.nombre_completo}.") }
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
		respond_to do |format|
			if @requerimiento.aprobar_por_sector!
				head :ok				
				respond_with @requerimiento, :notice => "Se autorizó el requerimiento", :location => @requerimiento
			else
				respond_with @requerimiento.errors, :status => :unprocessable_entity do |format|
					format.html{ render :show }
				end
			end
		end
	end

	# PUT /requerimientos/{id}/rechazar
	def rechazar
		logger.debug("Se rechaza el requerimiento")
		logger.debug(params[:rechazo])
		# FIXME: Falta verificar que funcione el parametro y como chequear el campo requerido		
		if @requerimiento.rechazar_por_sector!( params[:rechazo][:motivo] )
			# FIXME: Por algun motivo no muestra el mensaje al redirigir la petición
			respond_with @requerimiento, :notice => "Se rechazó el requerimiento y se envió un email al solicitante", :location => @requerimiento 
		else
			respond_with @requerimiento.errors, :status => :unprocessable_entity do |format|
				format.html{ render :motivo_rechazo }
			end
		end		
	end

	# GET /requerimientos/{id}/rechazar
	def motivo_rechazo	
	end

  def index
#    @requerimientos = Requerimiento.where(:solicitante_id => current_usuario)
		#	FIXME: El usuario puede ver sus requerimientos y los que debe autorizar
		respond_with( @requerimientos = Requerimiento.includes(:solicitante, :empresa, :sector, :rubro).all )
  end

  def show
  	respond_with(@requerimiento)
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



#  # DELETE /requerimientos/1
#  # DELETE /requerimientos/1.xml
#  def destroy
#    @requerimiento = Requerimiento.find(params[:id])
#    @requerimiento.destroy

#    respond_to do |format|
#      format.html { redirect_to(requerimientos_url) }
#      format.xml  { head :ok }
#    end
#  end

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

