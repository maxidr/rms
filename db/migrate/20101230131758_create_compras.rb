class CreateCompras < ActiveRecord::Migration
  def self.up
    create_table :compras do |t|
      t.date :fecha_probable_entrega
      t.date :fecha_entrega
      t.text :observaciones
      t.references :presupuesto
      t.references :requerimiento
    end
  end

  def self.down
    drop_table :compras
  end
end
