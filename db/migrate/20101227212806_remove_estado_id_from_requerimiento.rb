class RemoveEstadoIdFromRequerimiento < ActiveRecord::Migration
  def self.up
  	remove_column :requerimientos, :estado_id
  end

  def self.down
  	add_column :requerimientos, :estado_id, :integer, {:default => 0}
  end
end

