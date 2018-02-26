class AddColumnEstadoPagoIdToRequerimientos < ActiveRecord::Migration
  def self.up
    add_column :requerimientos, :estado_pago_id, :integer
  end

  def self.down
    remove_column :requerimientos, :estado_pago_id
  end
end
