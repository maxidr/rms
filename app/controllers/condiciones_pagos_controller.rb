# coding: utf-8
class CondicionesPagosController < ApplicationController

	before_filter :authenticate_usuario!

  # GET /condiciones_pagos
  # GET /condiciones_pagos.xml
  def index
    @condiciones_pagos = CondicionPago.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @condiciones_pagos }
    end
  end

  # GET /condiciones_pagos/1
  # GET /condiciones_pagos/1.xml
  def show
    @condicion_pago = CondicionPago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @condicion_pago }
    end
  end

  # GET /condiciones_pagos/new
  # GET /condiciones_pagos/new.xml
  def new
    @condicion_pago = CondicionPago.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @condicion_pago }
    end
  end

  # GET /condiciones_pagos/1/edit
  def edit
    @condicion_pago = CondicionPago.find(params[:id])
  end

  # POST /condiciones_pagos
  # POST /condiciones_pagos.xml
  def create
    @condicion_pago = CondicionPago.new(params[:condicion_pago])

    respond_to do |format|
      if @condicion_pago.save
        format.html { redirect_to(@condicion_pago, :notice => 'Condicion pago was successfully created.') }
        format.xml  { render :xml => @condicion_pago, :status => :created, :location => @condicion_pago }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @condicion_pago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /condiciones_pagos/1
  # PUT /condiciones_pagos/1.xml
  def update
    @condicion_pago = CondicionPago.find(params[:id])

    respond_to do |format|
      if @condicion_pago.update_attributes(params[:condicion_pago])
        format.html { redirect_to(@condicion_pago, :notice => 'Condicion pago was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @condicion_pago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /condiciones_pagos/1
  # DELETE /condiciones_pagos/1.xml
  def destroy
    @condicion_pago = CondicionPago.find(params[:id])
    @condicion_pago.destroy

    respond_to do |format|
      format.html { redirect_to(condiciones_pagos_url) }
      format.xml  { head :ok }
    end
  end
end

