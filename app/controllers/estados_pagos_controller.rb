class EstadosPagosController < ApplicationController
  # GET /estados_pagos
  # GET /estados_pagos.xml
  def index
    #@estados_pagos = EstadoPago.all

    @estados_pagos = EstadoPago.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @estados_pagos }
    end
  end

  # GET /estados_pagos/1
  # GET /estados_pagos/1.xml
  def show
    @estado_pago = EstadoPago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @estado_pago }
    end
  end

  # GET /estados_pagos/new
  # GET /estados_pagos/new.xml
  def new
    @estado_pago = EstadoPago.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @estado_pago }
    end
  end

  # GET /estados_pagos/1/edit
  def edit
    @estado_pago = EstadoPago.find(params[:id])
  end

  # POST /estados_pagos
  # POST /estados_pagos.xml
  def create
    @estado_pago = EstadoPago.new(params[:estado_pago])

    respond_to do |format|
      if @estado_pago.save
        format.html { redirect_to(@estado_pago, :notice => 'Estado pago was successfully created.') }
        format.xml  { render :xml => @estado_pago, :status => :created, :location => @estado_pago }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @estado_pago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /estados_pagos/1
  # PUT /estados_pagos/1.xml
  def update
    @estado_pago = EstadoPago.find(params[:id])

    respond_to do |format|
      if @estado_pago.update_attributes(params[:estado_pago])
        format.html { redirect_to(@estado_pago, :notice => 'Estado pago was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @estado_pago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /estados_pagos/1
  # DELETE /estados_pagos/1.xml
  def destroy
    @estado_pago = EstadoPago.find(params[:id])
    @estado_pago.destroy

    respond_to do |format|
      format.html { redirect_to(estados_pagos_url) }
      format.xml  { head :ok }
    end
  end

  def enable
    @estado_pago = EstadoPago.find(params[:id])
    @estado_pago.disabled_at = nil
    if @estado_pago.save
      flash[:notice] = "Se habilito estado de pago #{@estado_pago.nombre}"
    else
      flash[:error] = @estado_pago.errors.full_messages
    end
    redirect_to estados_pagos_path
  end

end
