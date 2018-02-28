class AddColumnComentarioToRequerimientos < ActiveRecord::Migration
  def self.up
    add_column :requerimientos, :comentario, :text
  end

  def self.down
    remove_column :requerimientos, :comentario
  end
end
