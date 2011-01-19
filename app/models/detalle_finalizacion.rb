class DetalleFinalizacion < ActiveRecord::Base
	belongs_to :responsable, :class_name => "Usuario"
end

