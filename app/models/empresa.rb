# == Schema Information
# Schema version: 20101130010846
#
# Table name: empresas
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Empresa < ActiveRecord::Base
	# FIXME: No se debe permitir que la eliminación física de los proveedores (habilitado: true, default_scope)
  validates :nombre, :presence => true

  def to_s
    nombre
  end
end

