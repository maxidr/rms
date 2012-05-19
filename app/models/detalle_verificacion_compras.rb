class DetalleVerificacionCompras < ActiveRecord::Base
  belongs_to :presupuesto
  has_many :verificaciones, :class_name => 'VerificacionEncargadoCompras', :through => :presupuesto

  def self.para_el_presupuesto(presupuesto)
    detalle = where(:presupuesto_id => presupuesto.id).first 
    detalle = new(:presupuesto => presupuesto, :aprobado => false) unless detalle             
    detalle
  end

  def aprobar_por(autorizante)
    verificaciones.create(:verificador => autorizante, 
                         :fecha_aprobacion => DateTime.now, 
                         :presupuesto => presupuesto)
  end

  def aprobacion_finalizada?(responsables_de_compras)
    return false if verificaciones.count < responsables_de_compras.size
    ids_de_verificaciones = verificaciones.select(:verificador_id).map { |v| v.id }
    ids_responsables = responsables_de_compras.map { |r| r.id }

    if ids_de_verificaciones.size > ids_responsables.size
      # Todos los responsables deben estar incluidos en los verificadores
      return ids_responsables.all? { |id| ids_de_verificaciones.include? id }
    end
    
    faltantes = ids_de_verificaciones - ids_responsables
    faltantes.empty?
  end

end
