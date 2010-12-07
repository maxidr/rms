# == Schema Information
# Schema version: 20101130010846
#
# Table name: sectores
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Sector < ActiveRecord::Base
  validates_presence_of :nombre, :responsable
  
  belongs_to :responsable, :class_name => 'Usuario'
  
  def nombre_responsable
  	responsable ? responsable.nombre_completo : '-'
  end

  def to_s
    nombre
  end
end
