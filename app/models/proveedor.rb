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
	# FIXME: No se debe permitir que la eliminación física de los proveedores (habilitado: true, default_scope)
	validates_presence_of :razon_social, :cuit
	validates_uniqueness_of :razon_social

	attr_accessible :razon_social, :domicilio, :telefono, :cuit,
										:localidad, :cod_postal,
										:representante, :jefe_ventas, :memo

end

