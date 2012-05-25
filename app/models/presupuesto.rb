# == Schema Information
# Schema version: 20101202182809
#
# Table name: presupuestos
#
#  id                :integer         not null, primary key
#  proveedor_id      :integer
#  moneda_id         :integer
#  monto             :decimal(8, 2)
#  condicion_pago_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  requerimiento_id  :integer
#  detalle           :string(255)
#  aprobado          :boolean         default(false)
#  seleccionado      :boolean         default(false)
#

# Un presupuesto es seleccionado dentro de un requerimiento cuando al menos un encargado de compras
# lo selecciona.  De ahí en mas, los demas encargados puede aprobar o rechazar solo el presupuesto
# seleccionado.
#
# Un presupuesto es aprobado cuando todos los encargados de compras verifican y aprueba el presupuesto
# seleccionado.
#
class Presupuesto < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  belongs_to :requerimiento
  belongs_to :proveedor
  belongs_to :moneda
  belongs_to :condicion_pago
  has_many :desgloses
  # Las verificaciones son las que indican que los encargados aprobaron o rechazaron el presupuesto.
  # Cuando un responsable verifica un presupuesto dentro de la lista que contiene el requerimiento, dicho
  # presupuesto pasa a estar "seleccionado".
  has_many :verificaciones, :class_name => 'VerificacionEncargadoCompras', 
    :after_add => :add_presupuesto_as_selected

  IVA = [21, 10.5, 0]

  #validates_presence_of :monto, :moneda, :condicion_pago, :proveedor
  validates_presence_of :moneda, :condicion_pago, :proveedor, :desgloses
 # validates_numericality_of :monto, :greater_than => 0
  validates_associated :desgloses

  accepts_nested_attributes_for :desgloses

  
  def monto_total
    desgloses.inject(0) { |sum, d| sum += d.monto_total }
  end
  memoize :monto_total
  
  def con_iva?
    desgloses.any? { |d| d.iva > 0 }
  end  
  memoize :con_iva?

  # ---------------------------------------------------------------------------------------------------------
  
  private
  
  def add_presupuesto_as_selected(verificacion)
    self.update_attribute(:seleccionado, true)
  end


end

