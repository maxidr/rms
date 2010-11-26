class SectoresController < ApplicationController
  # GET /sectores
  # GET /sectores.xml
  def index
    @sectores = Sector.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sectores }
    end
  end

  # GET /sectores/1
  # GET /sectores/1.xml
  def show
    @sector = Sector.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sector }
    end
  end

  # GET /sectores/new
  # GET /sectores/new.xml
  def new
    @sector = Sector.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sector }
    end
  end

  # GET /sectores/1/edit
  def edit
    @sector = Sector.find(params[:id])
  end

  # POST /sectores
  # POST /sectores.xml
  def create
    @sector = Sector.new(params[:sector])

    respond_to do |format|
      if @sector.save
        format.html { redirect_to(@sector, :notice => 'Sector was successfully created.') }
        format.xml  { render :xml => @sector, :status => :created, :location => @sector }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sector.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sectores/1
  # PUT /sectores/1.xml
  def update
    @sector = Sector.find(params[:id])

    respond_to do |format|
      if @sector.update_attributes(params[:sector])
        format.html { redirect_to(@sector, :notice => 'Sector was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sector.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sectores/1
  # DELETE /sectores/1.xml
  def destroy
    @sector = Sector.find(params[:id])
    @sector.destroy

    respond_to do |format|
      format.html { redirect_to(sectores_url) }
      format.xml  { head :ok }
    end
  end
end
