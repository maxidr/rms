class AddEmailToSector < ActiveRecord::Migration
  def self.up
		add_column :sectores, :email, :string
  end

  def self.down
  	remove_column :sectores, :email
  end
end
