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
    @material = Material.new(params[:material])

    respond_to do |format|
      if @material.save
        format.html { redirect_to(@material, :notice => 'Material was successfully created.') }
        format.xml  { render :xml => @material, :status => :created, :location => @material }
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
      format.html { redirect_to(materiales_url) }
      format.xml  { head :ok }
    end
  end
end
