# coding: utf-8
class AttachmentsController < ApplicationController
  respond_to :html, :xml

  # GET /materiales/new
  # GET /materiales/new.xml
  def new
    logger.debug("requerimiento #{params[:requerimiento_id]}")
    @requerimiento = Requerimiento.find params[:requerimiento_id].to_i unless params[:requerimiento_id].blank?
    @requerimiento = Presupuesto.find params[:presupuesto_id].to_i unless params[:presupuesto_id].blank?

    #@requerimiento = @presupuesto.requerimiento unless @presupuesto.blank?

    @attachment = Attachment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @attachment }
    end
  end

  def create
    @requerimiento = Requerimiento.find params[:requerimiento_id].to_i unless params[:requerimiento_id].blank?
    @requerimiento = Presupuesto.find params[:presupuesto_id].to_i unless params[:presupuesto_id].blank?

    @attachment = @requerimiento.attachments.build(params[:attachment])
    if @attachment.save
      #respond_with @requerimieto, status: :created, :location => requerimiento_url(@requerimiento)
      respond_to do |format|
        format.html { render :show }
      end
    else
      respond_with @attachment.errors, status: :unprocessable_entity do |format|
        format.html{ render :new }
      end
    end
  end

  def show
    @attachment = Attachment.find params[:id].to_i
    respond_to do |format|
      format.html
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.delete
    respond_to do |format|
      format.html { redirect_to(requerimiento_url(@attachment.attachable_id)) }
      format.xml  { head :ok }
    end
  end
end
