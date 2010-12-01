class CreateCaracteristicas < ActiveRecord::Migration
  def self.up
    create_table :caracteristicas do |t|
      t.string :nombre
      t.string :valor
      t.references :material

      t.timestamps
    end
  end

  def self.down
    drop_table :caracteristicas
  end
end
