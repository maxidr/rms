class CreateSectores < ActiveRecord::Migration
  def self.up
    create_table :sectores do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :sectores
  end
end
