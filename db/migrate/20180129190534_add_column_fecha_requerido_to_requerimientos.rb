class AddColumnFechaRequeridoToRequerimientos < ActiveRecord::Migration
  def self.up
    add_column :requerimientos, :fecha_requerido, :date
  end

  def self.down
    remove_column :requerimientos, :fecha_requerido
  end
end
