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
	
	attr_accessible :requerimiento, :detalle
	
	# FIXME: Muy fea la alternativa para obtener el codigo de estado
	scope :rechazados_por_sector, where(:codigo_estado => Requerimiento::ESTADOS.index(Requerimiento::RECHAZO_X_SECTOR))
	scope :del_requerimiento, lambda { |rqm| 	where(:requerimiento_id => rqm)	}
	
	def to_s
		"Codigo de estado: #{codigo_estado}, ID req: #{requerimiento.id}"
	end
end
