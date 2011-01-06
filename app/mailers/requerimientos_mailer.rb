# coding: utf-8
class RequerimientosMailer < ActionMailer::Base
  default :from => "rms.perseus@gmail.com"

  def solicitar_aprobacion_sector(requerimiento)
   	@requerimiento = requerimiento
  	mail(:to => requerimiento.sector.emails_responsables, :subject => 'Solicitud de autorización')
  end

  def informar_autorizacion_sector(requerimiento, autorizante)
  	@nombre_autorizante = autorizante.nombre_completo
  	@nro_rqm = requerimiento.id
  	@url = requerimiento_url(requerimiento)
  	mail(:to => requerimiento.solicitante.email, :subject => 'Solicitud autorizada por el responsable del sector')
  end

  def rqm_rechazado_por_sector(requerimiento, motivo)
  	@requerimiento = requerimiento
  	@motivo = motivo
  	mail(:to => requerimiento.solicitante.email, :subject => "Su requerimiento fue rechazado por el responsable del sector")
  end

  def solicitar_aprobacion_compras(rqm)
  	@requerimiento = rqm
  	sector = rqm.sector
  	mail :to => sector.emails_responsables,
  		:cc => sector.email,
	 		:subject => "Solicitud de autorización de requerimiento"
  end

  def informar_rechazo_compras(rqm, rechazado_por, motivo)
  	@requerimiento = rqm
  	@motivo = motivo
  	mail :to => rqm.solicitante.email,
  		:cc => rechazado_por.email,
  		:subject => "El requerimiento n° #{rqm.id} fue rechazado por compras"
  end

  def informar_autorizacion_compras(rqm, autorizante, presupuesto)
  	@requerimiento = rqm
  	@autorizante = autorizante.nombre_completo
  	@presupuesto = presupuesto
    mail :to => rqm.solicitante.email,
    	:cc => autorizante.email,
    	:subject => "El requerimiento n° #{rqm.id} fue aprobado por compras"
  end

	# Envía mails a expedición informando que hay una compra pendiente de recepción
  def informar_recepcion_pendiente(rqm, compra)
  	@fecha_probable_entrega = compra.fecha_probable_entrega
  	@requerimiento = rqm
  	mail :to => Sector.expedicion.emails,
  		:cc => rqm.solicitante.email,
  		:subject => "Se aguarda la recepción de lo solicitado en el requerimiento n° #{rqm.id}"
  end

	def informar_prevision_pago(rqm, compra)
		puts rqm
		puts compra.fecha_probable_entrega
		@requerimiento = rqm
		@fecha_probable_entrega = compra.fecha_probable_entrega
		@presupuesto = rqm.presupuesto_aprobado
		puts @fecha_probable_entrega
		mail :to => Sector.administracion.emails,
			:cc => rqm.solicitante.email,
			:subject => "Se solicita realizar una previsión de pago para el requerimiento n° #{rqm.id}"
	end

end

