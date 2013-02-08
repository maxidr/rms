class DetalleCancelacionCompras < ActiveRecord::Base
  belongs_to :cancelado_por, :class_name => "Usuario"

  def motivo
    nil
  end
end
