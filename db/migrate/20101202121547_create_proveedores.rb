class CreateProveedores < ActiveRecord::Migration
  def self.up
    create_table :proveedores do |t|
      t.string :razon_social
      t.text :domicilio
      t.string :telefono
      t.string :cuit
      t.text :contacto
      t.references :condicion_pago

      t.timestamps
    end
  end

  def self.down
    drop_table :proveedores
  end
end
