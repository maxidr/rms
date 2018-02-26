class AddColumnEntregadoToRequerimientos < ActiveRecord::Migration
  def self.up
    add_column :requerimientos, :entregado_at, :datetime
  end

  def self.down
    remove_column :requerimientos, :entregado_at
  end
end
