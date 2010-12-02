class CreateCondicionesPagos < ActiveRecord::Migration
  def self.up
    create_table :condiciones_pagos do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps
    end
  end

  def self.down
    drop_table :condiciones_pagos
  end
end
