
# Esta clase se invoca cuando se elimina un responsable de un sector
# Si el sector es compras debe verificar si algun requerimiento pasa a 
# estar aprobado por compras.  Los requerimientos que son verificados son
# aquellos que estan pendientes de aprobación por compras y aun les faltaba
# la aprobacion del algun responsable.
class ComprasResponsablesObserver
  def initialize(sector)
    @sector = sector
  end

  def notify
    return unless @sector == Sector.compras 
    responsables_de_compras = Sector.compras.responsables
    pendientes = Requerimiento.pendientes_de_aprobacion_compras
    pendientes.each do |rqm|
      presupuesto_seleccionado = rqm.presupuestos.seleccionado
      rqm.aprobar_presupuesto_por_compras!(presupuesto_seleccionado) if presupuesto_seleccionado
    end
  end
end
