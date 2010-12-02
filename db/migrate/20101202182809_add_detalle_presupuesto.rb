class AddDetallePresupuesto < ActiveRecord::Migration
  def self.up
	add_column :presupuestos, :detalle, :string
  end

  def self.down
	remove_column :presupuestos, :detalle
  end
end
