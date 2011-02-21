# coding: utf-8
class SectoresController < ApplicationController

	respond_to :html, :json, :xml

	before_filter :authenticate_usuario!
  load_and_authorize_resource

  # GET /sectores
  def index
		respond_with @sectores = @sectores.paginate(:page => params[:page], :per_page => 10)
		#@search = Proveedor.search(params[:search])
		#respond_with @proveedores = @search.paginate(:page => params[:page], :per_page => 15)
  end

  # GET /sectores/1
  def show
  	respond_with @sector
  end

  # GET /sectores/new
  # GET /sectores/new.xml
  def new
  	respond_with @sector
  end

  # GET /sectores/1/edit
  def edit
		respond_with @sector
  end

  # POST /sectores
  # POST /sectores.xml
  def create
    respond_to do |format|
      if @sector.save
        format.html { redirect_to(@sector, :notice => 'El sector fue creado con éxito.') }
        format.xml  { render :xml => @sector, :status => :created, :location => @sector }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sector.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sectores/1
  # PUT /sectores/1.xml
  def update
    respond_to do |format|
      if @sector.update_attributes(params[:sector])
        format.html { redirect_to(@sector, :notice => 'El sector fue actualizado con éxito.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sector.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sectores/1
  # DELETE /sectores/1.xml
  def destroy
    @sector.destroy

    respond_to do |format|
      format.html { redirect_to(sectores_url) }
      format.xml  { head :ok }
    end
  end
end

