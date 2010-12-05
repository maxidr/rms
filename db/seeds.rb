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

#Usuario.find_or_create_by_identificador(:nombre => 'Julian', :apellido => 'Rodriguez', :identificador => 'jrodriguez')

Moneda.find_or_create_by_simbolo(:simbolo => "$", :nombre => "Pesos")
Moneda.find_or_create_by_simbolo(:simbolo => "u$s", :nombre => "Dólares")

