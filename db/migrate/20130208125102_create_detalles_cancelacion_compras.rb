class CreateDetallesCancelacionCompras < ActiveRecord::Migration

  def self.up
    create_table :detalles_cancelacion_compras do |t|
      t.references :cancelado_por
    end
  end

  def self.down
    drop_table :detalles_cancelacion_compras
  end
end
