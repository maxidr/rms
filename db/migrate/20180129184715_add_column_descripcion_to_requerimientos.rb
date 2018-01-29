class AddColumnDescripcionToRequerimientos < ActiveRecord::Migration
  def self.up
    add_column :requerimientos, :descripcion, :text
  end

  def self.down
    remove_column :requerimientos, :descripcion
  end
end
