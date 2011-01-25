class RemoveContactoFromProveedores < ActiveRecord::Migration
  def self.up
  	remove_column :proveedores, :contacto
  end

  def self.down
		add_column :proveedores, :contacto, :text
  end
end
