# == Schema Information
# Schema version: 20101209121748
#
# Table name: sectores
#
#  id             :integer         not null, primary key
#  nombre         :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  responsable_id :integer
#

class Sector < ActiveRecord::Base
	# FIXME: No se debe permitir que la eliminación física de los sectores (habilitado: true, default_scope)
  belongs_to :responsable, :class_name => 'Usuario'

  validates_presence_of :nombre
  validates_uniqueness_of :nombre

	# IMPROVE: Mejorar el modo de fijar estos datos (tal vez se mejor generar una pantalla donde un usuario pueda indicar donde mandar los mails en cada estado del requerimiento)
	#	Se fijan estos valores ya que es importante identificar unequivocamente estos sectores
	# para el resto de los procesos (enviar notificaciones a compras, a administración y a expedición)
  COMPRAS_ID = 9
  ADMINISTRACION_ID = 8
  EXPEDICION_ID = 7

	def self.compras
		find(COMPRAS_ID)
	end

	def self.administracion
		find ADMINISTRACION_ID
	end

	def self.expedicion
		find EXPEDICION_ID
	end

	# Determina los emails del sector. Estos son: el mail del sector (si ubiera) y el del responsable (si ubiera).
	# @return [String] Los mails separados por comas
	def emails
		[email, responsable ? responsable.email : nil].compact.uniq.join(", ")
	end

  def nombre_responsable
  	responsable ? responsable.nombre_completo : '-'
  end

  def to_s
    nombre
  end
end

