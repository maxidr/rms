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
end
