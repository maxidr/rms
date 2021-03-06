# coding: utf-8
# == Schema Information
# Schema version: 20101201144013
#
# Table name: caracteristicas
#
#  id          :integer         not null, primary key
#  nombre      :string(255)
#  valor       :string(255)
#  material_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Caracteristica < ActiveRecord::Base
	validates_presence_of :nombre, :valor

  belongs_to :material

end

