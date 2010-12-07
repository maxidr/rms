class AddResponsableToSector < ActiveRecord::Migration
  def self.up
  	add_column :sectores, :responsable_id, :integer
  end

  def self.down
		remove_column :sectores, :responsable_id
  end
end
