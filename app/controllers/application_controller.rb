# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_ability
  	@current_ability ||= Ability.new(current_usuario)
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

