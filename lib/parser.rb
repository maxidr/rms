require 'csv'

file = '/home/maxi/Descargas/Proveedores Laindell.csv'
hash = ""
CSV.foreach(file) do |row|
	nombre = row[1]
	domicilio = row[2]
	localidad = row[3]
	cod_prov = row[4]
	codpost = row[5]
	telefono = row[6]
	representante = row[7]
	jefe_ventas = row[8]
	cuit = row[9]
	cod_iva = row[10]
  memo = row[14]
  
  puts "Proveedor.find_or_create_by_razon_social(
  	:razon_social => '#{nombre}', 
  	:domicilio => '#{domicilio}', 
  	:telefono => '#{telefono}',
  	:cuit => '#{cuit}',
  	
  	:localidad => '#{localidad}', 
		:cod_post => '#{codpost}', 		
  	:representante => '#{representante}', 
  	:jefe_ventas => '#{jefe_ventas}', 
  	:cuit => '#{cuit}', 
  	:cod_iva => '#{cod_iva}', 
  	:memo => '#{memo}' )"
end
