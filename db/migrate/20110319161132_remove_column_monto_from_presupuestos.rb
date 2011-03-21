class RemoveColumnMontoFromPresupuestos < ActiveRecord::Migration
  def self.up
    remove_column :presupuestos, :monto
  end

  def self.down
    add_column :presupuestos, :monto, :decimal, :precision => 8 ,:scale => 2
  end
end

