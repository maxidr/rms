# coding: utf-8
class DetalleRechazoSector < ActiveRecord::Base
	belongs_to :autorizante, :class_name => "Usuario"
  has_one :estados_historicos, :as => :detalle
    
  attr_accessible :motivo
  
  validates_presence_of :motivo
end
