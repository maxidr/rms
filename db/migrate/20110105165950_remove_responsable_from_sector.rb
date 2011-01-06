class RemoveResponsableFromSector < ActiveRecord::Migration
  def self.up
  	remove_column :sectores, :responsable_id
  end

  def self.down
  	raise ActiveRecord::IrreversibleMigration, "No se pueden recuperar el responsable de cada sector"
  end
end
