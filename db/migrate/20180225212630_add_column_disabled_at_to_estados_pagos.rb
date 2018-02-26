class AddColumnDisabledAtToEstadosPagos < ActiveRecord::Migration
  def self.up
    add_column :estados_pagos, :disabled_at, :datetime
  end

  def self.down
    remove_column :estados_pagos, :disabled_at
  end
end
