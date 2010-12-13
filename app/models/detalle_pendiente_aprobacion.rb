# coding: utf-8
class DetallePendienteAprobacion < ActiveRecord::Base	
  belongs_to :autorizante, :class_name => "Usuario"
  has_many :estados_historicos, :as => :detalle
end
