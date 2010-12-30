# coding: utf-8
class Compra < ActiveRecord::Base
  belongs_to :presupuesto
  belongs_to :requerimiento
  
	validates_presence_of :fecha_probable_entrega, :presupuesto, :requerimiento
	validate :fechas_no_pueden_ser_pasado
  
  attr_accessible :fecha_probable_entrega, :fecha_entrega, :observaciones, :presupuesto, :requerimiento
  
  # Verifica que las fechas no sean anteriores al día de hoy
  def fechas_no_pueden_ser_pasado
  	errors.add(:fecha_probable_entrega, "No puede ser anterior al día de hoy") if	
  		!fecha_probable_entrega.blank? and fecha_probable_entrega < Date.today
  	errors.add(:fecha_entrega, "No puede ser anterior al día de hoy") if
  		!fecha_entrega.blank? and fecha_entrega < Date.today
  end
  
end
