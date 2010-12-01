# == Schema Information
# Schema version: 20101130183643
#
# Table name: materiales
#
#  id               :integer         not null, primary key
#  nombre           :string(255)
#  cantidad         :string(255)
#  detalle          :text
#  created_at       :datetime
#  updated_at       :datetime
#  requerimiento_id :integer
#

class Material < ActiveRecord::Base	
  validates :nombre, :presence => true
  validates :cantidad, :presence => true
  
  belongs_to :requerimiento
  has_many :caracteristicas
end
