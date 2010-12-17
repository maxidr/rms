# coding: utf-8
class DetallePendienteAprobacion < ActiveRecord::Base
  belongs_to :autorizante, :class_name => "Usuario"
  has_one :estados_historicos, :as => :detalle

  def to_s
  	"Se solicitó el #{detalle.created_at} a #{autorizante.nombre_completo} que verifique y apruebe el requerido"
  end
end

