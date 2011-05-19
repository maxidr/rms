# coding: utf-8
class MaterialesController < ApplicationController

	before_filter :authenticate_usuario!
	before_filter :load_material, :only => [:show, :edit, :update, :destroy]
#	before_filter :check_rqm_state, :only => [:edit, :update, :destroy]
	before_filter :check_creation, :only => [:create, :new]

  # GET /materiales
  # GET /materiales.xml
  def index
    @requerimiento = Requerimiento.find(params[:requerimiento_id])
    @materiales = @requerimiento.materiales

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /materiales/1
  # GET /materiales/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @material }
    end
  end

  # GET /materiales/new
  # GET /materiales/new.xml
  def new
  	logger.debug("requerimiento #{params[:requerimiento_id]}")
    @material = Material.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @material }
    end
  end

  # GET /materiales/1/edit
  def edit
  end

  # POST /materiales
  # POST /materiales.xml
  def create
  	@material = @requerimiento.materiales.create(params[:material])

    logger.debug("Material a crear: #{@material}")

    respond_to do |format|
      if @material.save
        format.html { redirect_to(@requerimiento, :notice => "Se asigno el material al requerimiento nro: #{@requerimiento.id}") }
        format.xml  { render :xml => @material, :status => :created, :location => @requerimiento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @material.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /materiales/1
  # PUT /materiales/1.xml
  def update
    respond_to do |format|
      if @material.update_attributes(params[:material])
        format.html { redirect_to(@material, :notice => 'Material was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @material.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /materiales/1
  # DELETE /materiales/1.xml
  def destroy
    @material.destroy

    respond_to do |format|
      format.html { redirect_to(requerimiento_url(@material.requerimiento), :notice => "Se elimino el material \"#{@material.nombre}\"") }
      format.xml  { head :ok }
    end
  end

  private

#  def check_rqm_state
#		if cannot? :edit, @material.requerimiento
#			redirect_to @material, :alert => 'No puede alterar el contenido de un requerimiento hasta que no cambie su estado'
#		end
#	end

	def check_creation
		@requerimiento = Requerimiento.find(params[:requerimiento_id])
  	if cannot? :add_material, @requerimiento
  		redirect_to @requerimiento, :alert => 'No puede agregar materiales al requerimiento hasta que este no cambie su estado'
  	end
	end

	def load_material
		@material = Material.find(params[:id])
	end

end

