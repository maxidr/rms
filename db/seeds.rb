# coding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


# En principio las empresas serian  Laindell SRL  y  Metalurgica La Toma SA
# Los sectores : Tejeduria /  Mantenimiento / Recubrimiento / Embalaje / Fabrica de piletas / Caños /
# 							 Expedicion / Administracion / Compras / Ventas.
# Los rubros: Materias Primas / Insumos / Consumibles / Varios / Servicios / Maquinas y herramientas


Empresa.find_or_create_by_nombre('Laindell SRL')
Empresa.find_or_create_by_nombre('Metalúrgica La Toma SA')

Sector.find_or_create_by_nombre('Tejeduría')
Sector.find_or_create_by_nombre('Mantenimiento')
Sector.find_or_create_by_nombre('Recubrimiento')
Sector.find_or_create_by_nombre('Embalaje')
Sector.find_or_create_by_nombre('Fabrica de piletas')
Sector.find_or_create_by_nombre('Caños')
Sector.find_or_create_by_nombre('Expedición')
Sector.find_or_create_by_nombre('Administración')
Sector.find_or_create_by_nombre('Compras')
Sector.find_or_create_by_nombre('Ventas')

Rubro.find_or_create_by_nombre('Materias Primas')
Rubro.find_or_create_by_nombre('Insumos')
Rubro.find_or_create_by_nombre('Consumibles')
Rubro.find_or_create_by_nombre('Varios')
Rubro.find_or_create_by_nombre('Servicios')
Rubro.find_or_create_by_nombre('Maquinas y herramientas')

Moneda.find_or_create_by_simbolo(:simbolo => "$", :nombre => "Pesos")
Moneda.find_or_create_by_simbolo(:simbolo => "u$s", :nombre => "Dólares")

Usuario.create({:nombre => 'Maximiliano', :apellido => 'Dello Russo', 
	:identificador => 'mdellorusso', 
	:email => 'mdellorusso@aonken.com.ar', 
	:password => 'lucas12'}) unless Usuario.find_by_identificador('mdellorusso')
	
Proveedor.find_or_create_by_razon_social(
	:razon_social => 'Compañía Química', 
	:telefono => '44445555',
	:cuit => '30641212123',
	:contacto => 'Clau')
	
CondicionPago.find_or_create_by_nombre(	:nombre => 'Contado',	:descripcion => 'Cheques propios al dia')
CondicionPago.find_or_create_by_nombre(	:nombre => 'Efectivo anticipado en dólares',	:descripcion => 'u$s')	
CondicionPago.find_or_create_by_nombre(	:nombre => 'Efectivo anticipado en pesos',	:descripcion => '$')		
CondicionPago.find_or_create_by_nombre(	:nombre => 'Anticipado 15 dias',	:descripcion => 'Cheques 15 dias')	
CondicionPago.find_or_create_by_nombre(	:nombre => 'Anticipado 30 dias',	:descripcion => 'Cheques 30 dias')	
CondicionPago.find_or_create_by_nombre(	:nombre => 'Anticipado 45 dias	',	:descripcion => 'Cheque 45 dias')	
CondicionPago.find_or_create_by_nombre(	:nombre => 'Anticipado 7 dias',	:descripcion => 'Cheques 7 dias')	
CondicionPago.find_or_create_by_nombre(	:nombre => 'Fecha Factura 30',	:descripcion => 'Vencimiento factura 30 dias')
CondicionPago.find_or_create_by_nombre(	:nombre => 'Fecha Factura 45',	:descripcion => 'Vencimiento factura 45 dias')

