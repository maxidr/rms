class AddComposedOfEstadoToRequerimiento < ActiveRecord::Migration
  def self.up
  	add_column :requerimientos, :estado, :integer, :null => false, :default => 0
  end

  def self.down
  	remove_column :requerimientos, :estado
  end
end
