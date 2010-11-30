class AddMaterialesToRequerimiento < ActiveRecord::Migration
  def self.up
    change_table :materiales do |t|
      t.references :requerimiento
    end
  end

  def self.down
    remove_column :materiales, :requerimiento
  end
end
