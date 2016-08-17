class AddColumnUrlPoseidonToEmpresas < ActiveRecord::Migration
  def self.up
    add_column :empresas, :url_poseidon, :string
  end

  def self.down
    remove_column :empresas, :url_poseidon
  end
end
