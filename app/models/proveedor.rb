# == Schema Information
# Schema version: 20101202122214
#
# Table name: proveedores
#
#  id           :integer         not null, primary key
#  razon_social :string(255)
#  domicilio    :text
#  telefono     :string(255)
#  cuit         :string(255)
#  contacto     :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Proveedor < ActiveRecord::Base
#	FIXME: La razon social no debería ser obligatoria ya que podrían tener proveedores del exterior (que no poseen esta caracteristica)
	validates_presence_of :razon_social, :cuit
	validates_uniqueness_of :razon_social
end

