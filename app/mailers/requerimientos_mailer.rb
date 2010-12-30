# coding: utf-8
class RequerimientosMailer < ActionMailer::Base
  default :from => "mdellorusso@anses.gov.ar"
  
  def solicitar_aprobacion_sector(requerimiento, autorizante)
  	logger.debug("Enviando mail al responsable del sector #{requerimiento.sector.nombre}: #{autorizante}")
  	@usuario = autorizante
  	@requerimiento = requerimiento
  	@url = requerimiento_url(requerimiento)
  	mail(:to => autorizante.email, :subject => 'Solicitud de autorización')
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
		responsable = rqm.sector.responsable		
  	mail :to => responsable.email, 
  		:cc => rqm.sector.email,
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
end
