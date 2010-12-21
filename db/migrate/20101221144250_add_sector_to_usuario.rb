class AddSectorToUsuario < ActiveRecord::Migration
  def self.up
  	add_column :usuarios, :sector_id, :integer
  end

  def self.down
  	remove_column :usuarios, :sector_id
  end
end

