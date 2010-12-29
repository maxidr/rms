# coding: utf-8
# Guarda los detalles del rechazo de un requerimiento por el sector de compras
class DetalleRechazoCompras < ActiveRecord::Base
	belongs_to :rechazado_por, :class_name => "Usuario"
  has_one :estados_historicos, :as => :detalle

  attr_accessible :motivo, :rechazado_por

  validates_presence_of :motivo

end

