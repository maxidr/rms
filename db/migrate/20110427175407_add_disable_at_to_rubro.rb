class AddDisableAtToRubro < ActiveRecord::Migration
  def self.up
    add_column :rubros, :disabled_at, :datetime
  end

  def self.down
    remove_column :rubros, :disabled_at
  end
end
