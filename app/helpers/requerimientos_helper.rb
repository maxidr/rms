module RequerimientosHelper
  def iva_mark(requerimiento)
    aprobado = requerimiento.presupuestos.exists? ? requerimiento.presupuestos.aprobado : nil
    aprobado.con_iva? ? ' (*)' : ' ()' if aprobado
  end

  def responsables_faltantes(requerimiento)
    responsables_faltantes = DetalleVerificacionCompras.responsables_faltantes_para_aprobacion(requerimiento)
    if responsables_faltantes
      "#{responsables_faltantes.try(:to_sentence).downcase}"
    else
      " "
    end
  end

  def estado(requerimiento)
    estado = requerimiento.estado
    responsables_faltantes_sector = requerimiento.responsables_faltantes_para_aprobacion
    responsables_faltantes = DetalleVerificacionCompras.responsables_faltantes_para_aprobacion(requerimiento)
    if responsables_faltantes
      prefix = "Falta"
      prefix = "Faltan" if responsables_faltantes.size > 1
      estado = raw "#{estado}. <br/> #{prefix}: #{responsables_faltantes.try(:to_sentence)}"
    end
    if responsables_faltantes_sector.any?
      prefix = "Falta"
      prefix = "Faltan" if responsables_faltantes_sector.size > 1
      estado = raw "#{estado} <br/> Por el sector #{prefix}: #{responsables_faltantes_sector.try(:to_sentence)}"
    end
    estado
  end

end
