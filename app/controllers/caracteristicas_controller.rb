# coding: utf-8

class CaracteristicasController < ApplicationController
  # GET /caracteristicas
  # GET /caracteristicas.xml
  def index
    @caracteristicas = Caracteristica.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @caracteristicas }
    end
  end

  # GET /caracteristicas/1
  # GET /caracteristicas/1.xml
  def show
    @caracteristica = Caracteristica.find(params[:id])
		@material = @caracteristica.material

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @caracteristica }
    end
  end

  # GET /materiales/:material_id/caracteristicas/new
  # GET /materiales/:material_id/caracteristicas/new.xml
  def new
		@material = Material.find(params[:material_id])
    @caracteristica = Caracteristica.new
    @caracteristica.material = @material

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @caracteristica }
    end
  end

  # GET /caracteristicas/1/edit
  def edit
  	# TODO: Refactoring de la obtención de característica y material (DRY)
    @caracteristica = Caracteristica.find(params[:id])
  end

  # POST /materiales/:material_id/caracteristicas
  # POST /materiales/:material_id/caracteristicas.xml
  def create
  	@material = Material.find(params[:material_id])
    @caracteristica = @material.caracteristicas.create(params[:caracteristica])

    respond_to do |format|
      if @caracteristica.save
				format.html { redirect_to(@material, :notice => 'Se agregó la característica.') }
        format.xml  { render :xml => @caracteristica, :status => :created, :location => @material }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @caracteristica.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /caracteristicas/1
  # PUT /caracteristicas/1.xml
  def update
    @caracteristica = Caracteristica.find(params[:id])

    respond_to do |format|
      if @caracteristica.update_attributes(params[:caracteristica])
        format.html { redirect_to(@caracteristica.material, :notice => 'La característica fue actualizada.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @caracteristica.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /caracteristicas/1
  # DELETE /caracteristicas/1.xml
  def destroy
    @caracteristica = Caracteristica.find(params[:id])
    @caracteristica.destroy

    respond_to do |format|
      format.html { redirect_to material_url(@caracteristica.material) }
      format.xml  { head :ok }
    end
  end
end

