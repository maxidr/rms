class AddMoreInfoToProveedor < ActiveRecord::Migration
  def self.up
		add_column :proveedores, :localidad, :string
		add_column :proveedores, :cod_postal, :string
		add_column :proveedores, :representante, :string
		add_column :proveedores, :jefe_ventas, :string
		add_column :proveedores, :memo, :text		
  end

  def self.down
  	remove_columns :proveedores, :localidad, :cod_postal, :representante, :jefe_ventas, :memo
  end
end
