# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_ability
  	@current_ability ||= Ability.new(current_usuario)
  end

  rescue_from CanCan::AccessDenied do |exception|
  	logger.debug(exception.message)
    flash[:error] = "No posee permisos suficientes para acceder a la página solicitada"
    redirect_to root_url
  end
end

