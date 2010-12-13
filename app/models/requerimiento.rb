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

	ESTADOS = [INICIO, PENDIENTE_APROBACION_SECTOR, APROBADO_X_SECTOR, RECHAZO_X_SECTOR, CANCELADO]
	
	def aprobar_por_sector		
		self.estado = APROBADO_X_SECTOR
		EstadoHistorico.create(
			:codigo_estado => estado_id,
			:detalle => DetalleAprobacionSector.create(:autorizante => sector.responsable),
			:requerimiento => self)
		
		#	TODO: Enviar mail al solicitante informando que el sector aprobó el requerimiento
		self.save!
	end

	def solicitar_aprobacion_sector
		# Verificar que sea un estado válido
		logger.debug("Estado: #{estado}")
		unless estado == INICIO
			errors[:estado_id] = 'El estado del requerimiento es inválido'
			return false
		end
		
		unless sector.responsable
			errors[:base] = "El sector #{sector.nombre} aun no posee un responsable encargado. Informe al administrador de la situación y luego vuelva a intentarlo"
			return false
		end

		# Actualizar estado
		self.estado = PENDIENTE_APROBACION_SECTOR
		
		# Guardo la nueva transición de estado del requerimiento
		EstadoHistorico.create(
			:codigo_estado => PENDIENTE_APROBACION_SECTOR, 
			:detalle => DetallePendienteAprobacion.create(:autorizante => sector.responsable), 
			:requerimiento => self)
			
		# Enviar un mail al responsable del sector
		RequerimientosMailer.solicitar_aprobacion_sector(self, sector.responsable).deliver
		self.save!
  end


  def aprobable_by?(usuario)
  	estado == PENDIENTE_APROBACION_SECTOR && sector.responsable == usuario
  end

	def permite_solicitar_aprobacion?
		estado == INICIO && !materiales.empty?
	end

  def estado
  	ESTADOS[estado_id]
  end

  private

		def estado_id
			self[:estado_id]
		end

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

