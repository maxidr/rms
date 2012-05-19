class VerificacionEncargadoCompras < ActiveRecord::Base
  belongs_to :presupuesto
  belongs_to :autorizante, :class_name => 'Usuario'
end
