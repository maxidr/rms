class DetalleVerificacionCompras < ActiveRecord::Base
  belongs_to :presupuesto
  has_many :verificaciones, :class_name => 'VerificacionEncargadoCompras', :through => :presupuesto
end
