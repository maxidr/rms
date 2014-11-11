# coding: utf-8
class ProveedoresController < ApplicationController

	respond_to :html, :xml

	before_filter :authenticate_usuario!
	load_and_authorize_resource

  # GET /proveedores
  # GET /proveedores.xml
  def index
  	@search = Proveedor.search(search_params('razon_social.asc'))
    # FIXME: No está funcionando la cantidad de páginas (per_page) en el modelo.
		respond_with @proveedores = @search.paginate(:page => params[:page], :per_page => 15)
  end

  # GET /proveedores/1
  # GET /proveedores/1.xml
  def show
		respond_with @proveedor
  end

  # GET /proveedores/new
  # GET /proveedores/new.xml
  def new
    respond_with @proveedor
  end

  # GET /proveedores/1/edit
  def edit
  	respond_with @proveedor
  end

  # POST /proveedores
  # POST /proveedores.xml
  def create
    respond_to do |format|
      if @proveedor.save
        format.html { redirect_to(@proveedor, :notice => 'Los datos del proveedor fueron creados correctamente.') }
        format.xml  { render :xml => @proveedor, :status => :created, :location => @proveedor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proveedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proveedores/1
  # PUT /proveedores/1.xml
  def update
    respond_to do |format|
      if @proveedor.update_attributes(params[:proveedor])
        format.html { redirect_to(@proveedor, :notice => 'Los datos del proveedor fueron actualizados correctamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proveedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proveedores/1
  # DELETE /proveedores/1.xml
  def destroy
    @proveedor.destroy

    respond_to do |format|
      format.html { redirect_to(proveedores_url) }
      format.xml  { head :ok }
    end
  end

  def enable
    @proveedor.disabled_at = nil
    if @proveedor.save
      flash[:notice] = "Se habilitó el proveedor con razón social #{@proveedor.razon_social}"
    else
      flash[:error] = @proveedor.errors.full_messages
    end
    redirect_to proveedores_path
  end

  def get_by_cuit
    @proveedor = Proveedor.find_by_cuit(params[:cuit])

    if @proveedor.blank?
      @presupuestos = []
    else
      @presupuestos = @proveedor.presupuestos
    end

    render :json => @presupuestos
  end

end