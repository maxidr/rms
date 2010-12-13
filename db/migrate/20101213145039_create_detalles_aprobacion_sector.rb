class CreateDetallesAprobacionSector < ActiveRecord::Migration
  def self.up
    create_table :detalles_aprobacion_sector do |t|
      t.references :autorizante

      t.timestamps
    end
  end

  def self.down
    drop_table :detalles_aprobacion_sector
  end
end
