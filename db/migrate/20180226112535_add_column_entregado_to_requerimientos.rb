class AddColumnEntregadoToRequerimientos < ActiveRecord::Migration
  def self.up
    add_column :requerimientos, :entregado, :boolean
  end

  def self.down
    remove_column :requerimientos, :entregado
  end
end
