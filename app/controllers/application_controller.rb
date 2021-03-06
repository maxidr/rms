# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_usuario!, :except => [:get_by_cuit]

  def current_ability
  	@current_ability ||= Ability.new(current_usuario)
  end

  # Obtiene los parámetros de búsqueda y orden. En caso de no solicitarse el orden
  # en el request se utilizará la columna recibida como parámetro (default_sort).
  def search_params(default_sort = nil)
    return params[:search] if params[:search] && params[:search][:meta_sort]
    {'meta_sort' => default_sort }.merge(params[:search] || {}).symbolize_keys
  end

  rescue_from CanCan::AccessDenied do |exception|
  	logger.debug(exception.message)
  	msg = "No posee permisos suficientes para acceder a la página solicitada"
  	flash[:error] =  msg
  	respond_to do |format|
  		format.html { redirect_to root_url }
  		format.xml  { render :xml => {:error => msg}.to_xml(:root => :errors), :status => :forbidden }
  		format.json { render :json => {:error => msg}.to_json, :status => :forbidden }
  	end
  end
end

