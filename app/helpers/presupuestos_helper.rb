module PresupuestosHelper
  def precio_unitario(desglose, moneda)
    out = "#{moneda.simbolo} #{desglose.precio_unitario}"
    out << " + IVA" if desglose.mas_iva
    out
  end

  def iva(desglose)
    return 'Sin IVA' if desglose.iva == 0
    number_to_percentage desglose.iva, :strip_insignificant_zeros => true
  end
end

