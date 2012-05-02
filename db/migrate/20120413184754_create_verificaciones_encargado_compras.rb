class CreateVerificacionesEncargadoCompras < ActiveRecord::Migration
  def self.up
    create_table :verificaciones_encargado_compras do |t|
      t.integer :verificador_id
      t.datetime :fecha_aprobacion
      t.datetime :fecha_rechazo
      t.string :motivo_rechazo
      t.references :presupuesto

      t.timestamps
    end
  end

  def self.down
    drop_table :verificaciones_encargado_compras
  end
end
