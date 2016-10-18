class AutorizacionSector < ActiveRecord::Base
  belongs_to :autorizante, class_name: 'Usuario', foreign_key: 'autorizante_id'
  belongs_to :requerimiento, class_name: 'Requerimiento', foreign_key: 'requerimiento_id'

  def self.requerimiento_autorizado(autorizante, requerimiento)
    # verificar los autorizantes del sector
    # verificar si todos los autorizantes estan en la lista
    autorizaciones = AutorizacionSector.where(requerimiento_id: requerimiento.to_i,
                             autorizante_id: autorizante.to_i)

    if autorizaciones.empty?
      autoriza = AutorizacionSector.new(requerimiento_id: requerimiento.to_i,
                                        autorizante_id: autorizante.to_i)
      autoriza.save!
      autorizaciones = AutorizacionSector.where(requerimiento_id: requerimiento.to_i,
                               autorizante_id: autorizante.to_i)

    end
    autorizaciones
  end
end
