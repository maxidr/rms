class CreateDetallesPendienteAprobacion < ActiveRecord::Migration
  def self.up
    create_table :detalles_pendiente_aprobacion do |t|    	
      t.references :autorizante
    end
  end

  def self.down
    drop_table :detalles_pendiente_aprobacion
  end
end
