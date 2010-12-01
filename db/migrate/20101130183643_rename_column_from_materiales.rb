class RenameColumnFromMateriales < ActiveRecord::Migration
  def self.up
	  rename_column :materiales, :material, :nombre
	  # TODO: Falta agregar :null => false en otra migración
  end

  def self.down
		rename_column :materiales, :nombre, :material
  end
end
