class Pagar < ActiveRecord::Base
  belongs_to :presupuesto
  belongs_to :requerimiento

  validates_presence_of :fecha_pago, :requerimiento, :presupuesto
  #validate :fechas_no_pueden_ser_pasado

  attr_accessible :fecha_pago, :requerimiento_id, :presupuesto_id
end