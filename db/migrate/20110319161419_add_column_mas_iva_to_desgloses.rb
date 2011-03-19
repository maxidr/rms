class AddColumnMasIvaToDesgloses < ActiveRecord::Migration
  def self.up
    add_column :desgloses, :mas_iva, :boolean
  end

  def self.down
    remove_column :desgloses, :mas_iva
  end
end

