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

# FIXME Analizar y arreglar la dificultad con el encoding y los caracteres de acentuación
empresas = Empresa.create([{:nombre => 'Laindell SRL'}, {:nombre => 'Metalurgica La Toma SA'}])

sectores = Sector.create([{:nombre => 'Tejeduria'}, {:nombre => 'Mantenimiento'}, 
							{:nombre => 'Recubrimiento'}, {:nombre => 'Embalaje'}, 
							{:nombre => 'Fabrica de piletas'}, {:nombre => 'Canos'},
						  {:nombre => 'Expedicion'}, {:nombre => 'Administracion'},
						  {:nombre => 'Compras'}, {:nombre => 'Ventas'}])
						  
rubros = Rubro.create([{:nombre => 'Materias Primas'}, {:nombre => 'Insumos'}, 
							{:nombre => 'Consumibles'}, {:nombre => 'Varios'}, {:nombre => 'Servicios'},
							{:nombre => 'Maquinas y herramientas'}])
