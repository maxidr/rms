class CreateDetallesFinalizacion < ActiveRecord::Migration
  def self.up
    create_table :detalles_finalizacion do |t|
      t.references :responsable
    end
  end

  def self.down
    drop_table :detalles_finalizacion
  end
end

