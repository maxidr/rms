class Empresa < ActiveRecord::Base
  validates :nombre, :presence => true
end
