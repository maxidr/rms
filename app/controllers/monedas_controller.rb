# coding: utf-8
class MonedasController < ApplicationController

	respond_to :html, :json, :xml

	before_filter :authenticate_usuario!
  load_and_authorize_resource

  # GET /monedas
  # GET /monedas.xml
  def index
  	respond_with @monedas = @monedas.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /monedas/1
  # GET /monedas/1.xml
  def show
  	respond_with @moneda
  end

  # GET /monedas/new
  # GET /monedas/new.xml
  def new
  	respond_with @moneda
  end

  # GET /monedas/1/edit
  def edit
    respond_with @moneda
  end

  # POST /monedas
  # POST /monedas.xml
  def create
    respond_to do |format|
      if @moneda.save
        format.html { redirect_to(@moneda, :notice => "Se creó la moneda #{@moneda.nombre}.") }
        format.xml  { render :xml => @moneda, :status => :created, :location => @moneda }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @moneda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /monedas/1
  # PUT /monedas/1.xml
  def update
    respond_to do |format|
      if @moneda.update_attributes(params[:moneda])
        format.html { redirect_to(@moneda, :notice => 'Se actualizó la moneda #{@moneda.nombre}.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @moneda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /monedas/1
  # DELETE /monedas/1.xml
  def destroy
    @moneda.destroy

    respond_to do |format|
      format.html { redirect_to(monedas_url) }
      format.xml  { head :ok }
    end
  end

  def enable
    @moneda.disabled_at = nil
    if @moneda.save
      flash[:notice] = "Se habilitó la moneda #{@moneda.nombre}"
    else
      flash[:error] = @moneda.errors.full_messages
    end
    redirect_to monedas_path
  end
end
