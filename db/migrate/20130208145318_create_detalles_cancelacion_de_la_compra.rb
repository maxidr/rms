class CreateDetallesCancelacionDeLaCompra < ActiveRecord::Migration
  def self.up
    create_table :detalles_cancelacion_de_la_compra do |t|
      t.references :cancelado_por
      t.text :motivo
    end
  end

  def self.down
    drop_table :detalles_cancelacion_de_la_compra
  end
end
