class DetalleRecepcion < ActiveRecord::Base
  belongs_to :recepcionista, :class_name => 'Usuario'
  has_one :estados_historicos, :as => :detalle
end
