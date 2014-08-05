class Notificacion < ActiveRecord::Base
  belongs_to :requerimiento
  belongs_to :usuario

end