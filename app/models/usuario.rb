class Usuario < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :apellido, :presence => true
  validates :identificador, :presence => true, :uniqueness => true, :length => { :minimum => 4 }

  def to_s
    "#{nombre} #{apellido}"
  end
end
