class AddDisableAtToProveedores < ActiveRecord::Migration
  def self.up
    add_column :proveedores, :disabled_at, :datetime
  end

  def self.down
    remove_column :proveedores, :disabled_at
  end
end
