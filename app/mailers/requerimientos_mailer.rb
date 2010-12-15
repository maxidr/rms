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
end
