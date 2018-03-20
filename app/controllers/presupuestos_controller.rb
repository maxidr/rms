# coding: utf-8
class PresupuestosController < ApplicationController
	respond_to :html, :xml, :json

	before_filter :authenticate_usuario!

	before_filter :obtener_presupuesto_de_request, :only => [:edit, :update, :destroy, :aprobar, :show ]
	before_filter :obtener_requerimiento_de_request, :only => [:new, :create, :verificar_permisos_creacion]

	before_filter :verificar_permisos_modificacion, :only => [:edit, :update, :destroy]
	before_filter :verificar_permisos_creacion, :only => [:new, :create]

	def aprobar
		rqm = @presupuesto.requerimiento
		if rqm.aprobar_presupuesto_por_compras! @presupuesto, current_usuario
			flash[:notice] = "Se aprobó el presupuesto del requerimiento n° #{rqm.id}"
			respond_with rqm, :location => rqm
		else
			respond_with rqm.errors, :status => :unprocessable_entity do |format|
				format.html{ redirect_to rqm }
			end
		end
	end

	def show
    respond_with @presupuesto
	end

  # GET /presupuestos/new
  # GET /presupuestos/new.xml
  def new
    @presupuesto = Presupuesto.new
    @requerimiento.materiales.each do |material|
      @presupuesto.desgloses << Desglose.new(:material => material, :iva => 21.0)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @presupuesto }
    end
  end

  # GET /presupuestos/1/edit
  def edit
  end

  # POST /presupuestos
  # POST /presupuestos.xml
  def create
    @presupuesto = Presupuesto.new(params[:presupuesto])
    @presupuesto.requerimiento = @requerimiento

    respond_to do |format|
      if @presupuesto.save
        format.html { redirect_to(@requerimiento, :notice => 'Se agregó el presupuesto.') }
        format.xml  { render :xml => @presupuesto, :status => :created, :location => @presupuesto }
      else
        logger.debug "Errores: #{@presupuesto.errors}"
        format.html { render :action => "new" }
        format.xml  { render :xml => @presupuesto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /presupuestos/1
  # PUT /presupuestos/1.xml
  def update
    respond_to do |format|
      if @presupuesto.update_attributes(params[:presupuesto])
        if @presupuesto.aprobado == false && @presupuesto.requerimiento.estado == 5
          rqm = @presupuesto.requerimiento
          rqm.estado = Estado::PENDIENTE_APROBACION_COMPRAS
          rqm.save!
        end

        format.html { redirect_to(@presupuesto.requerimiento, :notice => 'Presupuesto actualizado.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @presupuesto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /presupuestos/1
  # DELETE /presupuestos/1.xml
  def destroy
    @presupuesto.destroy

    respond_to do |format|
      format.html { redirect_to(requerimiento_url(@presupuesto.requerimiento)) }
      format.xml  { head :ok }
    end
  end

  private

		def obtener_presupuesto_de_request
			@presupuesto = Presupuesto.find(params[:id])
		end

		def obtener_requerimiento_de_request
			@requerimiento = Requerimiento.find(params[:requerimiento_id])
		end

		def verificar_permisos_creacion
			authorize! :gestionar_presupuesto, @requerimiento
		end

		def verificar_permisos_modificacion
			rqm = @presupuesto.requerimiento
			authorize! :gestionar_presupuesto, rqm
		end

end

