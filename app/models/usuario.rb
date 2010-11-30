# == Schema Information
# Schema version: 20101130010846
#
# Table name: usuarios
#
#  id            :integer         not null, primary key
#  nombre        :string(255)
#  apellido      :string(255)
#  identificador :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Usuario < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :apellido, :presence => true
  validates :identificador, :presence => true, :uniqueness => true, :length => { :minimum => 4 }

  def to_s
    "#{nombre} #{apellido}"
  end
end
