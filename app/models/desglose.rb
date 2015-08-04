class Desglose < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  belongs_to :presupuesto
  belongs_to :material

  validates_presence_of :unidades, :precio_unitario, :iva, :material
  validates_numericality_of :unidades, :precio_unitario, :greater_than_or_equal_to => 0
  validates_inclusion_of :iva, :in => Presupuesto::IVA

  def precio_unitario_final
    return precio_unitario unless mas_iva
    precio_unitario + ( precio_unitario * iva / 100 )
  end

  def monto_total
    precio_unitario_final * unidades
  end
  memoize :monto_total

end

