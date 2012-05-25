class AddSeleccionadoToPresupuestos < ActiveRecord::Migration
  def self.up
    add_column :presupuestos, :seleccionado, :boolean, :default => false
  end

  def self.down
    remove_column :presupuestos, :seleccionado
  end
end
