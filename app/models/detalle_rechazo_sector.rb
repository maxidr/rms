# coding: utf-8
class DetalleRechazoSector < ActiveRecord::Base
	belongs_to :autorizante, :class_name => "Usuario"
  has_many :estados_historicos, :as => :detalle
end
