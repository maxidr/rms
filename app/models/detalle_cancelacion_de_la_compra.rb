class DetalleCancelacionDeLaCompra < ActiveRecord::Base
  belongs_to :cancelado_por, :class_name => "Usuario"

  validates_presence_of :motivo
  
end
