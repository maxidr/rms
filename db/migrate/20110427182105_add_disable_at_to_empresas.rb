class AddDisableAtToEmpresas < ActiveRecord::Migration
  def self.up
    add_column :empresas, :disabled_at, :datetime
  end

  def self.down
    remove_column :empresas, :disabled_at
  end
end
