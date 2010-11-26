class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.string :nombre
      t.string :apellido
      t.string :identificador

      t.timestamps
    end
  end

  def self.down
    drop_table :usuarios
  end
end
