# coding: utf-8
class PresupuestosController < ApplicationController

  # GET /presupuestos/new
  # GET /presupuestos/new.xml
  def new
  	@requerimiento = Requerimiento.find(params[:requerimiento_id])
    @presupuesto = Presupuesto.new    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @presupuesto }
    end
  end

  # GET /presupuestos/1/edit
  def edit
    @presupuesto = Presupuesto.find(params[:id])
  end

  # POST /presupuestos
  # POST /presupuestos.xml
  def create  
		@requerimiento = Requerimiento.find(params[:requerimiento_id])
		@presupuesto = @requerimiento.presupuestos.create(params[:presupuesto])   

    respond_to do |format|
      if @presupuesto.save
        format.html { redirect_to(@requerimiento, :notice => 'Se agregó el presupuesto.') }
        format.xml  { render :xml => @presupuesto, :status => :created, :location => @presupuesto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @presupuesto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /presupuestos/1
  # PUT /presupuestos/1.xml
  def update
    @presupuesto = Presupuesto.find(params[:id])

    respond_to do |format|
      if @presupuesto.update_attributes(params[:presupuesto])
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
    @presupuesto = Presupuesto.find(params[:id])
    @presupuesto.destroy

    respond_to do |format|
      format.html { redirect_to(requerimiento_url(@presupuesto.requerimiento)) }
      format.xml  { head :ok }
    end
  end
end
