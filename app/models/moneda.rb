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
	
	
  scope :enabled, where('monedas.disabled_at IS NULL')
  
	def enabled?
    self.disabled_at.nil?
	end
  
  # Evita que el sector sea eliminado físicamente de la base.
  def destroy
    self.update_attribute(:disabled_at, Time.now)
  end

end

