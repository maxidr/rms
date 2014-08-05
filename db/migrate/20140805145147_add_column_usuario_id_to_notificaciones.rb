class AddColumnUsuarioIdToNotificaciones < ActiveRecord::Migration
  def self.up
    add_column :notificaciones, :usuario_id, :integer
  end

  def self.down
    remove_column :notificaciones, :usuario_id
  end
end
