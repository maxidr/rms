module RequerimientosHelper
  def iva_mark(requerimiento)
    aprobado = requerimiento.presupuestos.exists? ? requerimiento.presupuestos.aprobado : nil
    aprobado.con_iva? ? ' (*)' : ' ()' if aprobado      
  end  

end
