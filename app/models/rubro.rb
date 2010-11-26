class Rubro < ActiveRecord::Base
  validates :nombre, :presence => true

  def to_s
    nombre
  end
end
