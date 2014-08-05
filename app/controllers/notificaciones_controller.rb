# coding: utf-8
class NotificacionesController < ApplicationController
  respond_to :html, :xml, :json

  before_filter :obtener_requerimiento_de_request, :only => [:new, :create]

  # GET /notifications/new
  # GET /notifications/new.xml
  def new
    @notificacion = Notificacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notificacion }
    end
  end

  def show
    respond_with @notificacion
  end

  # POST /presupuestos
  # POST /presupuestos.xml
  def create
    @notificacion = Notificacion.new(params[:notificacion])
    @notificacion.requerimiento_id = @requerimiento.id
    @notificacion.usuario_id = current_usuario

    respond_to do |format|
      if @notificacion.save
        format.html { redirect_to(@requerimiento, :notice => 'Se agregó la notificación.') }
        format.xml  { render :xml => @notificacion, :status => :created, :location => @notificacion }
      else
        logger.debug "Errores: #{@notificacion.errors}"
        format.html { render :action => "new" }
        format.xml  { render :xml => @notificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
  def obtener_requerimiento_de_request
    @requerimiento = Requerimiento.find(params[:requerimiento_id])
  end
end