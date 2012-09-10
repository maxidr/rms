class DetalleVerificacionCompras < ActiveRecord::Base
  belongs_to :presupuesto

  # Determina quienes son los responsables de compras que faltan aprobar
  # un presupuesto.
  # Si no hay presupuestos aprobados por ninguno de los responsables, retorna todos los responsables de compras
  # Si el requerimiento no se encuentra en estado 'aguardando autorización de compras' retorna nil
  def self.responsables_faltantes_para_aprobacion(requerimiento)
    if requerimiento.estado == Estado::PENDIENTE_APROBACION_COMPRAS
      presupuesto_aprobado = requerimiento.presupuestos.seleccionado
      if presupuesto_aprobado
        detalle = para_el_presupuesto(presupuesto_aprobado)
        return detalle.responsables_faltantes_para_aprobacion(Sector.compras.responsables)
      else
        return Sector.compras.responsables
      end
    end
    nil
  end

  def self.para_el_presupuesto(presupuesto)
    detalle = where(:presupuesto_id => presupuesto.id).first 
    detalle = new(:presupuesto => presupuesto, :aprobado => false) unless detalle             
    detalle
  end

  def aprobar_por(autorizante)
    v = presupuesto.verificaciones.build(:verificador_id => autorizante.id, :fecha_aprobacion => DateTime.now)
    v.save!
    self
  end

  def aprobacion_finalizada?(responsables_de_compras)
    responsables_faltantes_para_aprobacion(responsables_de_compras).empty?
  end

  def responsables_faltantes_para_aprobacion(responsables_de_compras)
    verificaciones = presupuesto.verificaciones(true)
    ids_de_verificaciones = verificaciones.select(:verificador_id).map { |v| v.verificador_id }
    responsables_de_compras.select { |responsable| !ids_de_verificaciones.include?(responsable.id) }    
  end


end
