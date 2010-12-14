class AddNotNullEstadoOnRequerimiento < ActiveRecord::Migration
  def self.up
  	change_column_null :requerimientos, :estado_id, false, 0
  end

  def self.down
  	change_column_null :requerimientos, :estado_id, true, 0
  end
end

