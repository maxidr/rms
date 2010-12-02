class CreatePresupuestos < ActiveRecord::Migration
  def self.up
    create_table :presupuestos do |t|
      t.references :proveedor
      t.references :moneda
      t.decimal :monto, :precision => 8 ,:scale => 2
      t.references :condicion_pago

      t.timestamps
    end
  end

  def self.down
    drop_table :presupuestos
  end
end
