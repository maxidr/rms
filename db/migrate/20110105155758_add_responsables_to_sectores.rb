class AddResponsablesToSectores < ActiveRecord::Migration
  def self.up
  	create_table :sectores_usuarios, :id => false do |table|
  		table.integer :usuario_id
  		table.integer :sector_id
  	end

  	say "Se transfiere el responsable del sector a la lista de responsables"
  	i = 0
  	Sector.all.each do |s|
  		s.responsables << s.responsable unless s.responsable.nil?
  		i += 1 if s.save
  	end
  	say "Se modificaron #{i} sectores"

  end

  def self.down
  	drop_table :sectores_usuarios
  end
end

