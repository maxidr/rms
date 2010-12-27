# coding: utf-8
class Estado
	include Comparable

	attr_reader :codigo, :nombre
	
	def initialize( codigo )
		@@estados ||= { 0 => 'Iniciado', 
										1 => 'Pendiente de aprobación por sector',
										2 => 'Rechazado por el sector',
										3 => 'Aprobado por el sector',										
										4 => 'Aguardando autorización de compras',
										99 => 'Cancelado'}

		@codigo = codigo
		raise "El valor #{codigo} es un código de estado inválido" unless @@estados.key? codigo
		@nombre = @@estados[@codigo]
	end
	
	INICIO 												= Estado.new 0
	PENDIENTE_APROBACION_SECTOR 	=	Estado.new 1
	RECHAZO_X_SECTOR 							= Estado.new 2
	APROBADO_X_SECTOR 						=	Estado.new 3
	PENDIENTE_APROBACION_COMPRAS 	=	Estado.new 4
	CANCELADO 										= Estado.new 99	

	
	def ==(other_estado)
		self.codigo == other_estado.codigo
	end
	
	def in?(*estados)
		estados.each do |estado|
			return true if self == estado
		end
		false
	end	
	
	def to_s
		nombre
	end
		
end
