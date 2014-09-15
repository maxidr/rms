class CreatePagares < ActiveRecord::Migration
  def self.up
    create_table :pagares do |t|
      t.date :fecha_pago
      t.integer :requerimiento_id
      t.integer :presupuesto_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pagares
  end
end
