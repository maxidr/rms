class AddMoreInfoToProveedor < ActiveRecord::Migration
  def self.up
		add_column :proveedores, :localidad, :string
		add_column :proveedores, :cod_postal, :string
		add_column :proveedores, :representante, :string
		add_column :proveedores, :jefe_ventas, :string
		add_column :proveedores, :memo, :text		
  end

  def self.down
  	drop_column :proveedores, :localidad
  	drop_column :proveedores, :cod_postal
  	drop_column :proveedores, :representante
  	drop_column :proveedores, :jefe_ventas
  	drop_column :proveedores, :memo
  end
end
