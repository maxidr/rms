# coding: utf-8

# == Schema Information
# Schema version: 20101213114613
#
# Table name: estados_historicos
#
#  id               :integer         not null, primary key
#  codigo_estado    :integer         default(0), not null
#  requerimiento_id :integer
#  detalle_id       :integer
#  detalle_type     :string(255)
#  created_at       :datetime
#

class EstadoHistorico < ActiveRecord::Base
	belongs_to :requerimiento
	belongs_to :detalle, :polymorphic => true, :dependent => :destroy

	attr_accessible :requerimiento, :detalle, :codigo_estado

	# IMPROVE: Agregar el estado como composed_of
	scope :rechazados_por_sector, where(:codigo_estado => Estado::RECHAZO_X_SECTOR.codigo)
	scope :del_requerimiento, lambda { |rqm| 	where(:requerimiento_id => rqm)	}
	scope :rechazados, where(:codigo_estado => [Estado::RECHAZO_X_COMPRAS, Estado::RECHAZO_X_SECTOR].collect{|e| e.codigo})
	scope :rechazados_del_requerimiento, lambda{ |rqm| rechazados.del_requerimiento(rqm) }

	def to_s
		"Codigo de estado: #{codigo_estado}, ID req: #{requerimiento.id}"
	end
end

