# coding: utf-8
class DetalleRechazoSector < ActiveRecord::Base
	belongs_to :autorizante, :class_name => "Usuario"
#  has_one :estados_historicos, :as => :detalle

  attr_accessible :motivo, :autorizante

  validates_presence_of :motivo

  def to_s
  	"El requerimiento fue rechazado por #{autorizante.nombre_completo} como responsable del sector"
  end
end

