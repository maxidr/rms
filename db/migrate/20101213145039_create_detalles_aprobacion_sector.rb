class CreateDetallesAprobacionSector < ActiveRecord::Migration
  def self.up
    create_table :detalles_aprobacion_sector do |t|
      t.references :autorizante
			# FIXME: Quitar el timestamps ya que la fecha esta en el estadoHistorico
      t.timestamps
    end
  end

  def self.down
    drop_table :detalles_aprobacion_sector
  end
end

