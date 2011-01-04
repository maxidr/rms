# coding: utf-8
class EmpresasController < ApplicationController

	respond_to :html, :xml

	before_filter :authenticate_usuario!
	load_and_authorize_resource

  # GET /empresas
  # GET /empresas.xml
  def index
    respond_with @empresas
  end

  # GET /empresas/1
  # GET /empresas/1.xml
  def show
		respond_with @empresa
  end

  # GET /empresas/new
  # GET /empresas/new.xml
  def new
		respond_with @empresa
  end

  # GET /empresas/1/edit
  def edit
		respond_with @empresa
  end

  # POST /empresas
  # POST /empresas.xml
  def create
    respond_to do |format|
      if @empresa.save
        format.html { redirect_to(@empresa, :notice => 'Empresa was successfully created.') }
        format.xml  { render :xml => @empresa, :status => :created, :location => @empresa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @empresa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /empresas/1
  # PUT /empresas/1.xml
  def update
    respond_to do |format|
      if @empresa.update_attributes(params[:empresa])
        format.html { redirect_to(@empresa, :notice => 'Empresa was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @empresa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /empresas/1
  # DELETE /empresas/1.xml
  def destroy
    @empresa.destroy

    respond_to do |format|
      format.html { redirect_to(empresas_url) }
      format.xml  { head :ok }
    end
  end
end

