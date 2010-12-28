class CreateDetalleAprobacionCompras < ActiveRecord::Migration
  def self.up
  	create_table :detalles_aprobacion_compras do |t|
			t.references :autorizante
			t.references :presupuesto
    end
  end

  def self.down
  	drop_table :detalles_aprobacion_compras
  end
end

