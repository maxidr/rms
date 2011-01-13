# coding: utf-8
class UsuariosController < ApplicationController

  load_and_authorize_resource

  # GET /usuarios
  # GET /usuarios.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
  	load_sector_and_rol
    respond_to do |format|
      if @usuario.save
        format.html { redirect_to(@usuario, :notice => 'El usuario fue creado correctamente.') }
        format.xml  { render :xml => @usuario, :status => :created, :location => @usuario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
		if params[:usuario][:password].blank?
      [:password,:password_confirmation,:current_password].collect{|p| params[:usuario].delete(p) }
  	end

		load_sector_and_rol

    respond_to do |format|
      if @usuario.errors[:base].empty? and @usuario.update_attributes(params[:usuario])
        format.html { redirect_to(@usuario, :notice => 'Los datos del usuario fueron correctamente actualizados.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to(usuarios_url) }
      format.xml  { head :ok }
    end
  end
  
  private

	
  def load_sector_and_rol
  	if can? :change_rol_and_sector, current_usuario
			@usuario.sector_id = params[:usuario][:sector_id]
			@usuario.rol = params[:usuario][:rol]
		end  	
  end
end

