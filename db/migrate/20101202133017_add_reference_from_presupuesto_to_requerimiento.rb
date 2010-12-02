class AddReferenceFromPresupuestoToRequerimiento < ActiveRecord::Migration
  def self.up	
  	add_column :presupuestos, :requerimiento_id, :integer
  end

  def self.down
  	remove_column :presupuestos, :requerimiento_id
  end
end
