# coding: utf-8
class DetalleAprobacionSector < ActiveRecord::Base
  belongs_to :autorizante, :class_name => "Usuario"
  has_one :estados_historicos, :as => :detalle

	def to_s
		"Requerimiento aprobado por #{autorizante.nombre_completo} como responsable del sector"
	end
end

