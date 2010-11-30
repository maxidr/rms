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
  validates :nombre, :presence => true

  def to_s
    nombre
  end
end
