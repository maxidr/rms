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
#

class Presupuesto < ActiveRecord::Base
  belongs_to :requerimiento
  belongs_to :proveedor
  belongs_to :moneda
  belongs_to :condicion_pago

  validates_presence_of :monto, :moneda, :condicion_pago, :proveedor
  validates_numericality_of :monto, :greater_than => 0

end

