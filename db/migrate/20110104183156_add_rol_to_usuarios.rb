class AddRolToUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :rol_id, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :usuarios, :rol_id
  end
end

