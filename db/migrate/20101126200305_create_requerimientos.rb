class CreateRequerimientos < ActiveRecord::Migration
  def self.up
    create_table :requerimientos do |t|
      t.references :solicitante
      t.references :empresa
      t.references :sector
      t.references :rubro

      t.timestamps
    end
  end

  def self.down
    drop_table :requerimientos
  end
end
