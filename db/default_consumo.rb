# Este script localiza todos los requerimientos que no poseen selección del consumo
# y cargan 'eventual' por defecto.  Esto corrige el issue #146
# Para ejecutar:
#   rails runner db/default_consumo.rb

Requerimiento.where('consumo IS NULL').each do |requerimiento|
  requerimiento.consumo = 'eventual'
  requerimiento.save
end
