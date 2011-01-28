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


# USUARIOS -------------------------------------------------------------------------------------------
unless usr = Usuario.find_by_identificador('mdellorusso')
	usr = Usuario.create({:nombre => 'Maximiliano', :apellido => 'Dello Russo',
		:identificador => 'mdellorusso',
		:email => 'maxidr@gmail.com',
		:password => 'lucas12'})
#	usr.sector = Sector.where(:nombre => 'Mantenimiento').first
#	puts "El usuario mdellorusso no pudo ser creado" unless usr.save
	usr.save
end

responsable = Usuario.find_by_identificador('jlopez')
if responsable.nil?
	responsable = Usuario.create({:nombre => 'Juan', :apellido => 'Lopez',
		:identificador => 'jlopez',
		:email => 'mdellorusso@aonken.com.ar',
		:password => 'jlopez', :rol => 'operador'})
#	responsable.sector = Sector.where(:nombre => 'Compras').first
#	puts "El usuario jlopez no pudo ser creado" unless responsable.save
	responsable.save
end

# SECTORES -------------------------------------------------------------------------------------------
# ES MUY IMPORTANTE QUE "Expedición", "Administración" y "Compras" reciban como ID el 7, 8 y 9 respectivamente.
# Ver modelo sector
#sectores = ["Tejeduría", "Mantenimiento", "Recubrimiento",
#	"Embalaje", "Fábrica de piletas", "Caños", "Expedición",
#	"Administración", "Compras", "Ventas" ]

#sectores.each do |sector|
#	unless Sector.find_by_nombre(sector)
#		sector = Sector.new({:nombre => sector})
#		sector.responsables << responsable
#		unless sector.valid?
#			puts "Inválido: #{sector.errors}"
#		end
#		sector.save
#	end
#end

#sectores.each do |nombre_sector|
#	sector = Sector.where(:nombre => nombre_sector).first
#	sector.responsables << responsable
#	sector.save
#end

# EMPRESAS -------------------------------------------------------------------------------------------
Empresa.find_or_create_by_nombre('Laindell SRL')
Empresa.find_or_create_by_nombre('Metalúrgica La Toma SA')
Empresa.find_or_create_by_nombre('Empresa de Prueba')

# RUBROS ---------------------------------------------------------------------------------------------

Rubro.find_or_create_by_nombre('Materias Primas')
Rubro.find_or_create_by_nombre('Insumos')
Rubro.find_or_create_by_nombre('Consumibles')
Rubro.find_or_create_by_nombre('Varios')
Rubro.find_or_create_by_nombre('Servicios')
Rubro.find_or_create_by_nombre('Maquinas y herramientas')
Rubro.find_or_create_by_nombre('Repuestos y accesorios')


# MONEDAS --------------------------------------------------------------------------------------------
Moneda.find_or_create_by_simbolo(:simbolo => "$", :nombre => "Pesos")
Moneda.find_or_create_by_simbolo(:simbolo => "u$s", :nombre => "Dólares")
Moneda.find_or_create_by_simbolo(:simbolo => "€", :nombre => 'Euros')

# PROVEEDOR ------------------------------------------------------------------------------------------
# Utiliza la clase que se encuentra en lib/csvimport.rb
require 'csvimport'
CSVImport.new(RAILS_ROOT + '/db/proveedores.csv').load do |row|
	Proveedor.find_or_create_by_razon_social(
		:razon_social 	=> row[1],
		:domicilio 			=> row[2],
		:telefono 			=> row[6],
		:cuit 					=> row[9],
		:localidad 			=> row[3],
		:cod_postal 		=> row[5],
		:representante 	=> row[7],
		:jefe_ventas 		=> row[8],
		:memo 					=> row[14])
end

# CONDICIONES DE PAGO ---------------------------------------------------------------------------------
CondicionPago.find_or_create_by_nombre(:nombre => 'Contado', :descripcion => 'Cheques propios al dia')
CondicionPago.find_or_create_by_nombre(:nombre => 'Efectivo anticipado', :descripcion => 'u$s')
CondicionPago.find_or_create_by_nombre(:nombre => ' Efectivo anticipado', :descripcion => '$')
CondicionPago.find_or_create_by_nombre(:nombre => 'Anticipado 15 dias', :descripcion => 'Cheques 15 dias')
CondicionPago.find_or_create_by_nombre(:nombre => 'Anticipado 30 dias', :descripcion => 'Cheques  30 dias')
CondicionPago.find_or_create_by_nombre(:nombre => 'Anticipado 45 dias', :descripcion => 'Cheques 45 dias')
CondicionPago.find_or_create_by_nombre(:nombre => 'Anticipado 7 dias', :descripcion => 'Cheques 7 dias')
CondicionPago.find_or_create_by_nombre(:nombre => 'Fecha Factura 30', :descripcion => 'Vencimiento factura 30 dias')
CondicionPago.find_or_create_by_nombre(:nombre => 'Fecha Factura 45', :descripcion => 'Vencimiento factura 45 dias')
CondicionPago.find_or_create_by_nombre(:nombre => 'Efectivo anticipado en dólares', :descripcion => 'u$s')
CondicionPago.find_or_create_by_nombre(:nombre => 'Efectivo anticipado en pesos', :descripcion => '$')
CondicionPago.find_or_create_by_nombre(:nombre => 'Anticipado 45 dias	', :descripcion => 'Cheque 45 dias')

