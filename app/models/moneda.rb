# == Schema Information
# Schema version: 20101202121547
#
# Table name: monedas
#
#  id         :integer         not null, primary key
#  simbolo    :string(255)
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Moneda < ActiveRecord::Base
	validates_presence_of :simbolo, :nombre
	validates_uniqueness_of :simbolo
end
