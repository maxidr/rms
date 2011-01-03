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
										5 => 'Aprobado por compras',
										6 => 'Rechazado por compras',
										7 => 'Comprado, pendiente de recepción',
										8 => 'Recepción pendiente de verificación',
										9 => 'Entrega verificada',
										10 => 'Finalizado',
										-1 => 'Cancelado'}

		@codigo = codigo
		raise "El valor #{codigo} es un código de estado inválido" unless @@estados.key? codigo
		@nombre = @@estados[@codigo]
	end

	INICIO 												= Estado.new 0
	PENDIENTE_APROBACION_SECTOR 	=	Estado.new 1
	RECHAZO_X_SECTOR 							= Estado.new 2
	APROBADO_X_SECTOR 						=	Estado.new 3
	PENDIENTE_APROBACION_COMPRAS 	=	Estado.new 4
	APROBADO_X_COMPRAS						= Estado.new 5
	RECHAZO_X_COMPRAS							= Estado.new 6
	PENDIENTE_RECEPCION						= Estado.new 7
	PENDIENTE_VERIFICACION				= Estado.new 8
	ENTREGADO											= Estado.new 9
	FINALIZADO										= Estado.new 10
	CANCELADO 										= Estado.new -1



	def <=>(other_estado)
		codigo <=> other_estado.codigo
	end

	def in?(*estados)
		estados.each do |estado|
			return true if self == estado
		end
		false
	end

	def rechazo?
		in? RECHAZO_X_COMPRAS, RECHAZO_X_SECTOR
	end

	def to_s
		nombre
	end

end

