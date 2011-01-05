# coding: utf-8
class ProveedoresController < ApplicationController

	respond_to :html, :xml

	before_filter :authenticate_usuario!
  load_and_authorize_resource

  # GET /proveedores
  # GET /proveedores.xml
  def index
		respond_with @proveedores
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
end

