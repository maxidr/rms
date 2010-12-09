# coding: utf-8
class Workflow
	INICIO = 'Iniciado'
	PENDIENTE_APROBACION_SECTOR = 'Pendiente aprobacion del sector'
	RECHAZO_X_SECTOR = 'Rechazado para sector'
	APROBADO_X_SECTOR = 'Aprobado por el sector'

	ESTADOS = [INICIO, PENDIENTE_APROBACION_SECTOR, APROBADO_X_SECTOR, RECHAZO_X_SECTOR]

	attr_reader :estado

	def initialize(id = 0)
		if id < 0 || id > ESTADOS.size - 1 then raise 'Estado inválido' end
		@estado = ESTADOS[id]
	end

	def solicitar_aprobacion_sector
		raise 'El estado del requerimiento es inválido' if @estado != INICIO
		@estado = PENDIENTE_APROBACION_SECTOR
	end

	def aprobar_rqm_por_sector(usuario)

	end

end

