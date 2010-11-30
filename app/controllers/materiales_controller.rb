class MaterialesController < ApplicationController
  # GET /materiales
  # GET /materiales.xml
  def index
    @materiales = Material.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @materiales }
    end
  end

  # GET /materiales/1
  # GET /materiales/1.xml
  def show
    @material = Material.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @material }
    end
  end

  # GET /materiales/new
  # GET /materiales/new.xml
  def new
  	logger.debug("requerimiento #{params[:requerimiento_id]}")
  	@requerimiento = Requerimiento.find(params[:requerimiento_id])
    @material = Material.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @material }
    end
  end

  # GET /materiales/1/edit
  def edit
    @material = Material.find(params[:id])
  end

  # POST /materiales
  # POST /materiales.xml
  def create
  	@requerimiento = Requerimiento.find(params[:requerimiento_id]) 
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
    @material = Material.find(params[:id])

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
    @material = Material.find(params[:id])
    @material.destroy

    respond_to do |format|
      format.html { redirect_to(requerimiento_url(@material.requerimiento), :notice => "Se elimino el material \"#{@material.material}\"") }
      format.xml  { head :ok }
    end
  end
end
