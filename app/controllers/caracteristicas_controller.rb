# coding: utf-8
class CaracteristicasController < ApplicationController
	before_filter :authenticate_usuario!
	before_filter :load_caracteristica, :only => [:show, :edit, :update, :destroy]
	before_filter :check_rqm_state, :only => [:edit, :update, :destroy]
	before_filter :check_creation, :only => [:create, :new]

	def check_rqm_state
		if cannot? :edit_caracteristica, @caracteristica.material
			redirect_to @caracteristica.material, :alert => 'No puede alterar el contenido de un requerimiento hasta que no cambie su estado'
		end
	end

	def check_creation
		@material = Material.find(params[:material_id])
  	if cannot? :add_caracteristica, @material
  		redirect_to @material, :alert => 'No puede agregar característica al material hasta que el requerimiento no cambie su estado'
  	end
	end

	def load_caracteristica
		@caracteristica = Caracteristica.find(params[:id])
	end

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
    @caracteristica.destroy

    respond_to do |format|
      format.html { redirect_to material_url(@caracteristica.material) }
      format.xml  { head :ok }
    end
  end
end

