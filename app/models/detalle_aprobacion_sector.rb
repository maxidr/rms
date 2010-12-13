# coding: utf-8
class DetalleAprobacionSector < ActiveRecord::Base
  belongs_to :autorizante, :class_name => "Usuario"
  has_many :estados_historicos, :as => :detalle
end
