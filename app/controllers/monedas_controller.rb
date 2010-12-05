# coding: utf-8
class MonedasController < ApplicationController

	before_filter :authenticate_usuario!

  # GET /monedas
  # GET /monedas.xml
  def index
    @monedas = Moneda.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @monedas }
    end
  end

  # GET /monedas/1
  # GET /monedas/1.xml
  def show
    @moneda = Moneda.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @moneda }
    end
  end

  # GET /monedas/new
  # GET /monedas/new.xml
  def new
    @moneda = Moneda.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @moneda }
    end
  end

  # GET /monedas/1/edit
  def edit
    @moneda = Moneda.find(params[:id])
  end

  # POST /monedas
  # POST /monedas.xml
  def create
    @moneda = Moneda.new(params[:moneda])

    respond_to do |format|
      if @moneda.save
        format.html { redirect_to(@moneda, :notice => 'Moneda was successfully created.') }
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
    @moneda = Moneda.find(params[:id])

    respond_to do |format|
      if @moneda.update_attributes(params[:moneda])
        format.html { redirect_to(@moneda, :notice => 'Moneda was successfully updated.') }
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
    @moneda = Moneda.find(params[:id])
    @moneda.destroy

    respond_to do |format|
      format.html { redirect_to(monedas_url) }
      format.xml  { head :ok }
    end
  end
end

