class CreateDesgloses < ActiveRecord::Migration
  def self.up
    create_table :desgloses do |t|
      t.string :detalle
      t.integer :unidades
      t.decimal :precio_unitario
      t.decimal :iva
      t.decimal :precio_final
      t.references :presupuesto
      t.references :material

      t.timestamps
    end
  end

  def self.down
    drop_table :desgloses
  end
end
