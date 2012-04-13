class AddConsumoInRequerimientos < ActiveRecord::Migration
  def self.up
    add_column :requerimientos, :consumo, :string 
  end

  def self.down
    remove_column :requerimientos, :consumo
  end
end
