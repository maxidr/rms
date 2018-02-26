class CreateEstadosPagos < ActiveRecord::Migration
  def self.up
    create_table :estados_pagos do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :estados_pagos
  end
end
