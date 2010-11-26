class RequerimientosController < ApplicationController
  # GET /requerimientos
  # GET /requerimientos.xml
  def index
    @requerimientos = Requerimiento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requerimientos }
    end
  end

  # GET /requerimientos/1
  # GET /requerimientos/1.xml
  def show
    @requerimiento = Requerimiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requerimiento }
    end
  end

  # GET /requerimientos/new
  # GET /requerimientos/new.xml
  def new
    @requerimiento = Requerimiento.new
    # FIXME Quitar el usuario hardcodeado 
    @requerimiento.solicitante = Usuario.find(1)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @requerimiento }
    end
  end

  # GET /requerimientos/1/edit
  def edit
    @requerimiento = Requerimiento.find(params[:id])
  end

  # POST /requerimientos
  # POST /requerimientos.xml
  def create
    @requerimiento = Requerimiento.new(params[:requerimiento])

    respond_to do |format|
      if @requerimiento.save
        format.html { redirect_to(@requerimiento, :notice => 'Requerimiento was successfully created.') }
        format.xml  { render :xml => @requerimiento, :status => :created, :location => @requerimiento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @requerimiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /requerimientos/1
  # PUT /requerimientos/1.xml
  def update
    @requerimiento = Requerimiento.find(params[:id])

    respond_to do |format|
      if @requerimiento.update_attributes(params[:requerimiento])
        format.html { redirect_to(@requerimiento, :notice => 'Requerimiento was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @requerimiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /requerimientos/1
  # DELETE /requerimientos/1.xml
  def destroy
    @requerimiento = Requerimiento.find(params[:id])
    @requerimiento.destroy

    respond_to do |format|
      format.html { redirect_to(requerimientos_url) }
      format.xml  { head :ok }
    end
  end
end
