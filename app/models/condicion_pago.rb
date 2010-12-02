# == Schema Information
# Schema version: 20101202121547
#
# Table name: condiciones_pagos
#
#  id          :integer         not null, primary key
#  nombre      :string(255)
#  descripcion :text
#  created_at  :datetime
#  updated_at  :datetime
#

class CondicionPago < ActiveRecord::Base
	validates :nombre, :presence => true, :uniqueness => true	
end