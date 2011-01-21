class CreateDetallesRechazoEntrega < ActiveRecord::Migration
  def self.up
    create_table :detalles_rechazo_entrega do |t|
    	t.references :rechazado_por
      t.text :motivo
    end
  end

  def self.down
    drop_table :detalles_rechazo_entrega
  end
end
