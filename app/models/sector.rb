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
	# FIXME: No se debe permitir que la eliminación física de los proveedores (habilitado: true, default_scope)
  belongs_to :responsable, :class_name => 'Usuario'

  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  scope :compras, where('sectores.nombre = ?', 'Compras')

  def nombre_responsable
  	responsable ? responsable.nombre_completo : '-'
  end

  def to_s
    nombre
  end
end

