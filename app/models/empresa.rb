# == Schema Information
# Schema version: 20101130010846
#
# Table name: empresas
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Empresa < ActiveRecord::Base
  validates :nombre, :presence => true

  scope :enabled, where('empresas.disabled_at IS NULL')

	def enabled?
    self.disabled_at.nil?
	end

  # Evita que el sector sea eliminado físicamente de la base.
  def destroy
    self.update_attribute(:disabled_at, Time.now)
  end

  def to_s
    nombre
  end
end
