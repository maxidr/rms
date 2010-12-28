# coding: utf-8
class DetalleAprobacionCompras < ActiveRecord::Base
  belongs_to :autorizante, :class_name => "Usuario"
  belongs_to :presupuesto

#  has_one :estados_historicos, :as => :detalle

end

