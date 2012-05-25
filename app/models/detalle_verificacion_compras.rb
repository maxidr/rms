class DetalleVerificacionCompras < ActiveRecord::Base
  belongs_to :presupuesto

  def verificaciones(force_reload = false)
    presupuesto.verificaciones(force_reload)
  end

  def self.para_el_presupuesto(presupuesto)
    detalle = where(:presupuesto_id => presupuesto.id).first 
    detalle = new(:presupuesto => presupuesto, :aprobado => false) unless detalle             
    detalle
  end

  def aprobar_por(autorizante)
    v = VerificacionEncargadoCompras.new(:verificador_id => autorizante.id, :fecha_aprobacion => DateTime.now, :presupuesto => presupuesto)
    v.save!
    self
  end

  def aprobacion_finalizada?(responsables_de_compras)
    return false if presupuesto.verificaciones(true).count < responsables_de_compras.size
    ids_de_verificaciones = presupuesto.verificaciones.select(:verificador_id).map { |v| v.verificador_id }
    ids_responsables = responsables_de_compras.map { |r| r.id }
    if ids_de_verificaciones.size > ids_responsables.size
      # Todos los responsables deben estar incluidos en los verificadores
      return ids_responsables.all? { |id| ids_de_verificaciones.include? id }
    end
    faltantes = ids_de_verificaciones - ids_responsables
    faltantes.empty?
  end

end
