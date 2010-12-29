class CreateDetallesRechazoCompras < ActiveRecord::Migration
  def self.up
    create_table :detalles_rechazo_compras do |t|
    	t.references :rechazado_por
      t.text :motivo
    end
  end

  def self.down
    drop_table :detalles_rechazo_compras
  end
end

