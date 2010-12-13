class CreateEstadosHistoricos < ActiveRecord::Migration
  def self.up
  	create_table :estados_historicos do |t|
  		t.integer :codigo_estado, :default => 0, :null => false
  		t.references :requerimiento
  		t.references :detalle, :polymorphic => true
  		t.datetime :created_at
  	end
  end

  def self.down
  	drop_table :estados_historicos
  end
end
