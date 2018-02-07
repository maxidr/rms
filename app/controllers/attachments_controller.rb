# coding: utf-8
class AttachmentsController < ApplicationController
  respond_to :html, :xml

  # GET /materiales/new
  # GET /materiales/new.xml
  def new
    logger.debug("requerimiento #{params[:requerimiento_id]}")
    @requerimiento = Requerimiento.find params[:requerimiento_id].to_i
    @attachment = Attachment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @attachment }
    end
  end

  def create
    @requerimiento = Requerimiento.find params[:requerimiento_id].to_i
    @attachment = @requerimiento.attachments.build(params[:attachment])
    if @attachment.save
      respond_with @attachment, :status => :created, :location => new_requerimiento_attachment_url(@requerimiento)
    else
      respond_with @attachment.errors, :status => :unprocessable_entity do |format|
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

end
