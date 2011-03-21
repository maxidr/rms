class RemoveColumnPrecioFinalFromDesgloses < ActiveRecord::Migration
  def self.up
    remove_column :desgloses, :precio_final
  end

  def self.down
    add_column :desgloses, :precio_final, :decimal
  end
end

