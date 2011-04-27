class AddDisableAtToMonedas < ActiveRecord::Migration
  def self.up
    add_column :monedas, :disabled_at, :datetime
  end

  def self.down
    remove_column :monedas, :disabled_at
  end
end
