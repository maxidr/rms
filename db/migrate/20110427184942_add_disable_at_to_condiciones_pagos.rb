class AddDisableAtToCondicionesPagos < ActiveRecord::Migration
  def self.up
    add_column :condiciones_pagos, :disabled_at, :datetime
  end

  def self.down
    remove_column :condiciones_pagos, :disabled_at
  end
end
