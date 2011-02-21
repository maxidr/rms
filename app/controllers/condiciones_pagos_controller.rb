# coding: utf-8
class CondicionesPagosController < ApplicationController

	respond_to :html, :json, :xml

	before_filter :authenticate_usuario!
  load_and_authorize_resource

  # GET /condiciones_pagos
  # GET /condiciones_pagos.xml
  def index
		respond_with @condiciones_pagos = @condiciones_pagos.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /condiciones_pagos/1
  # GET /condiciones_pagos/1.xml
  def show
  	respond_with @condicion_pago
  end

  # GET /condiciones_pagos/new
  # GET /condiciones_pagos/new.xml
  def new
  	respond_with @condicion_pago
  end

  # GET /condiciones_pagos/1/edit
  def edit
    respond_with @condicion_pago
  end

  # POST /condiciones_pagos
  # POST /condiciones_pagos.xml
  def create
    respond_to do |format|
      if @condicion_pago.save
        format.html { redirect_to(@condicion_pago, :notice => 'La condición de pago fue creada exitosamente.') }
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
    respond_to do |format|
      if @condicion_pago.update_attributes(params[:condicion_pago])
        format.html { redirect_to(@condicion_pago, :notice => 'La condición de pago fue actualizado correctamente.') }
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
    @condicion_pago.destroy

    respond_to do |format|
      format.html { redirect_to(condiciones_pagos_url) }
      format.xml  { head :ok }
    end
  end
end

