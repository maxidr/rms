class CreateDetallesRecepcion < ActiveRecord::Migration
  def self.up
    create_table :detalles_recepcion do |t|
      t.references :recepcionista
    end
  end

  def self.down
    drop_table :detalles_recepcion
  end
end
