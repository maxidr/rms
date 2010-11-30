	# == Schema Information
# Schema version: 20101130010846
#
# Table name: materiales
#
#  id         :integer         not null, primary key
#  material   :string(255)
#  cantidad   :string(255)
#  detalle    :text
#  created_at :datetime
#  updated_at :datetime
#

class Material < ActiveRecord::Base	
  validates :material, :presence => true
  validates :cantidad, :presence => true
  
  belongs_to :requerimiento  
end
