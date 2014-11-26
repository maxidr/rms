class AddColumnFechaVencimientoToPresupuestos < ActiveRecord::Migration
  def self.up
    add_column :presupuestos, :fecha_entrega, :date
  end

  def self.down
    remove_column :presupuestos, :fecha_entrega
  end
end
