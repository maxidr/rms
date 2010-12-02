class RemoveCondicionPagoFromProveedor < ActiveRecord::Migration
  def self.up
  	remove_column :proveedores, :condicion_pago_id
  end

  def self.down
  	add_column :proveedores, :condicion_pago_id
  end
end
