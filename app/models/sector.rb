class Sector < ActiveRecord::Base
  validates :nombre, :presence => true
end
