# coding: utf-8
class RequerimientosController < ApplicationController

	before_filter :authenticate_usuario!
	before_filter :obtener_rqm, :only => [:edit, :solicitar_aprobacion, :check_state, :show, :update, :aprobar]
	before_filter :check_state, :only => [:edit, :update]

	def obtener_rqm
		@requerimiento = Requerimiento.find(params[:id])
	end

	def check_state
    if cannot? :edit, @requerimiento
    	@requerimiento.errors[:base] = 'El requerimiento no puede ser modificado hasta que no cambie de estado'
    	render :action => :show
    end
	end

	def solicitar_aprobacion
		logger.debug("Se desea solicitar aprobacion del requerimiento #{@requerimiento.id}")
		respond_to do |format|
			if @requerimiento.solicitar_aprobacion_sector
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

	def aprobar
		logger.debug("Se aprueba el requerimiento")
		authorize! :aprobar_por_sector, @requerimiento		
		respond_to do |format|
			if @requerimiento.aprobar_por_sector
				format.html { redirect_to(@requerimiento, :notice => "Se autorizó el requerimiento") }
				format.xml  { head :ok }
			else
				format.html { render :action => "show" }
        format.xml  { render :xml => @requerimiento.errors, :status => :unprocessable_entity }
			end
		end
	end

	def rechazar
		# TODO: Implementar
		logger.debug("Se rechaza el requerimiento")		
	end
	
	def motivo_rechazo
		@detalle = DetalleRechazoSector.create()
		respond_to do |format|
			format.html
			format.xml { render :xml  => @detalle }
			format.json{ render :json => @detalle }
		end
	end

  # GET /requerimientos
  # GET /requerimientos.xml
  def index
#    @requerimientos = Requerimiento.where(:solicitante_id => current_usuario)
		#	FIXME: El usuario puede ver sus requerimientos y los que debe autorizar
		@requerimientos = Requerimiento.includes(:solicitante, :empresa, :sector, :rubro).all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requerimientos }
      format.json { render :json => @requerimientos }
    end
  end

  # GET /requerimientos/1
  # GET /requerimientos/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requerimiento }
    end
  end

  # GET /requerimientos/new
  # GET /requerimientos/new.xml
  def new
    @requerimiento = Requerimiento.new
    @requerimiento.solicitante = current_usuario

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @requerimiento }
    end
  end

  # GET /requerimientos/1/edit
  def edit
  end

  # POST /requerimientos
  # POST /requerimientos.xml
  def create
    @requerimiento = Requerimiento.new(params[:requerimiento])

    respond_to do |format|
      if @requerimiento.save
        format.html { redirect_to new_requerimiento_material_url(@requerimiento) }
        format.xml  { render :xml => @requerimiento, :status => :created, :location => @requerimiento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @requerimiento.errors, :status => :unprocessable_entity }
      end
    end
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

end

