# coding: utf-8

# == Schema Information
# Schema version: 20101209121748
#
# Table name: requerimientos
#
#  id             :integer         not null, primary key
#  solicitante_id :integer
#  empresa_id     :integer
#  sector_id      :integer
#  rubro_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#  estado_id      :integer         default(0)
#
class Requerimiento < ActiveRecord::Base
  belongs_to :solicitante, :class_name => "Usuario"
  belongs_to :empresa
  belongs_to :sector
  belongs_to :rubro
  has_many :materiales
  has_many :presupuestos

  validates_presence_of :empresa, :sector, :rubro, :solicitante

	INICIO = 'Iniciado'
	PENDIENTE_APROBACION_SECTOR = 'Pendiente aprobacion del sector'
	RECHAZO_X_SECTOR = 'Rechazado para sector'
	APROBADO_X_SECTOR = 'Aprobado por el sector'
	CANCELADO = 'Cancelado'
	PENDIENTE_APROBACION_COMPRAS = 'Aguardando autorización de compras'

	ESTADOS = [INICIO, PENDIENTE_APROBACION_SECTOR, APROBADO_X_SECTOR, RECHAZO_X_SECTOR, CANCELADO, PENDIENTE_APROBACION_COMPRAS]
	
	def solicitar_aprobacion_compras!
		self.estado = PENDIENTE_APROBACION_COMPRAS
		EstadoHistorico.create(:codigo_estado => estado_id,	:requerimiento => self)
		# TODO: Enviar mail al sector de compras
		
		self.save!
	end

	def aprobar_por_sector!
		self.estado = APROBADO_X_SECTOR
		EstadoHistorico.create(
			:codigo_estado => estado_id,
			:detalle => DetalleAprobacionSector.create(:autorizante => sector.responsable),
			:requerimiento => self)

		RequerimientosMailer.informar_autorizacion_sector(self, sector.responsable).deliver
		self.save!
	end

	def rechazar_por_sector!(motivo)
		if motivo.blank?
			errors[:base] = "Debe especificar un motivo para el rechazo"
			return false
		end

		self.estado = RECHAZO_X_SECTOR
		logger.debug("Autorizante: #{sector.responsable} (#{sector.nombre_responsable})")
		logger.debug("Código de estado: #{estado_id}")
		EstadoHistorico.create(
			:codigo_estado => estado_id,
			:detalle => DetalleRechazoSector.create(:autorizante => sector.responsable, :motivo => motivo),
			:requerimiento => self)

		RequerimientosMailer.rqm_rechazado_por_sector(self, motivo).deliver
		self.save!
	end

	def solicitar_aprobacion_sector!
		# Verificar que sea un estado válido
		logger.debug("Estado: #{estado}")

		unless sector.responsable
			errors[:base] = "El sector #{sector.nombre} aun no posee un responsable encargado. Informe al administrador de la situación y luego vuelva a intentarlo"
			return false
		end

		# Actualizar estado
		self.estado = PENDIENTE_APROBACION_SECTOR

		# Guardo la nueva transición de estado del requerimiento
		EstadoHistorico.create(
			:codigo_estado => estado_id,
			:detalle => DetallePendienteAprobacion.create(:autorizante => sector.responsable),
			:requerimiento => self)

		# Enviar un mail al responsable del sector
		RequerimientosMailer.solicitar_aprobacion_sector(self, sector.responsable).deliver
		self.save!
  end

	def motivo_rechazo
		estado_historico = EstadoHistorico.rechazados_por_sector.del_requerimiento(self).last
		estado_historico.detalle.motivo
	end


  def estado
  	ESTADOS[estado_id]
  end

  def estado_id
		self[:estado_id]
	end

  private

		def estado_id=(val)
			write_attribute :estado_id, val
		end

		def estado=(val)
			id = ESTADOS.index(val)
			unless id
				raise 'Intenta modificar el estado a uno inválido'
			end
			write_attribute :estado_id, id
		end

end

