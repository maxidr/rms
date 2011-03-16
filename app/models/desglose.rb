class Desglose < ActiveRecord::Base
  belongs_to :presupuesto
  belongs_to :material
  
  def precio_unitario_con_iva        
    return (precio_unitario * iva) / 100 unless precio_unitario.nil?
  end
  
  def precio_unitario_con_iva=(monto)
    precio_unitario |= (monto * 100) / iva
  end
end
