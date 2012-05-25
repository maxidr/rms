class VerificacionEncargadoCompras < ActiveRecord::Base
  belongs_to :presupuesto
  belongs_to :verificador, :class_name => 'Usuario'
end
