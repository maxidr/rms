class CreateDetallesRechazoSector < ActiveRecord::Migration
  def self.up
    create_table :detalles_rechazo_sector do |t|
			t.references :autorizante
			t.text :motivo
    end
  end

  def self.down
    drop_table :detalle_rechazos_sectores
  end
end
