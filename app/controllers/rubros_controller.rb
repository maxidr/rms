# coding: utf-8
class RubrosController < ApplicationController

	respond_to :html

	before_filter :authenticate_usuario!
  load_and_authorize_resource

  # GET /rubros
  # GET /rubros.xml
  def index
    respond_with @rubros = @rubros.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /rubros/1
  # GET /rubros/1.xml
  def show
  	respond_with @rubro
  end

  # GET /rubros/new
  # GET /rubros/new.xml
  def new
  	respond_with @rubro
  end

  # GET /rubros/1/edit
  def edit
    respond_with @rubro
  end

  # POST /rubros
  # POST /rubros.xml
  def create
    respond_to do |format|
      if @rubro.save
        format.html { redirect_to(@rubro, :notice => 'Rubro was successfully created.') }
        format.xml  { render :xml => @rubro, :status => :created, :location => @rubro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rubro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rubros/1
  # PUT /rubros/1.xml
  def update
    respond_to do |format|
      if @rubro.update_attributes(params[:rubro])
        format.html { redirect_to(@rubro, :notice => 'Rubro was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rubro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rubros/1
  # DELETE /rubros/1.xml
  def destroy
    @rubro.destroy

    respond_to do |format|
      format.html { redirect_to(rubros_url) }
      format.xml  { head :ok }
    end
  end
end

