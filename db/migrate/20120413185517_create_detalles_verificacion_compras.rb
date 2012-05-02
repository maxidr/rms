class CreateDetallesVerificacionCompras < ActiveRecord::Migration
  def self.up
    create_table :detalles_verificacion_compras do |t|
      t.boolean :aprobado
      t.references :presupuesto
    end
  end

  def self.down
    drop_table :detalles_verificacion_compras
  end
end
