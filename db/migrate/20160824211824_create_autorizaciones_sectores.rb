class CreateAutorizacionesSectores < ActiveRecord::Migration
  def self.up
    create_table :autorizaciones_sectores do |t|
      t.integer :requerimiento_id
      t.integer :autorizante_id

      t.timestamps
    end
  end

  def self.down
    drop_table :autorizaciones_sectores
  end
end
