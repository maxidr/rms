class AddDisabledAtToSector < ActiveRecord::Migration
  def self.up
    add_column :sectores, :disabled_at, :datetime
  end

  def self.down
    remove_column :sectores, :disabled_at
  end
end
