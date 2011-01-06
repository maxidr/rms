# coding: utf-8
# Contiene el detalle del estado "pendiente de aprobación del sector"
# FIXME: Debe eliminarse este modelo ya que no se guardan detalles de este estado (guardar los autorizantes no tiene utilidad)
class DetallePendienteAprobacion < ActiveRecord::Base
  belongs_to :autorizante, :class_name => "Usuario"
  has_one :estados_historicos, :as => :detalle

  def to_s
  	"Se solicitó el #{detalle.created_at} a #{autorizante.nombre_completo} que verifique y apruebe el requerido"
  end
end

