class AddFieldAprobadoToPresupuesto < ActiveRecord::Migration
  def self.up
  	add_column :presupuestos, :aprobado, :boolean, :default => false
  end

  def self.down
  	remove_column :presupuestos, :aprobado
  end
end

