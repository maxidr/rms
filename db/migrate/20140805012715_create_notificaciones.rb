class CreateNotificaciones < ActiveRecord::Migration
  def self.up
    create_table :notificaciones do |t|
      t.integer :requerimiento_id
      t.text :body
      t.string :subject

      t.timestamps
    end
  end

  def self.down
    drop_table :notificaciones
  end
end
