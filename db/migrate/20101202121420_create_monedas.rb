class CreateMonedas < ActiveRecord::Migration
  def self.up
    create_table :monedas do |t|
      t.string :simbolo
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :monedas
  end
end
