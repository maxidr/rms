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
#  estado        :integer         default(0)
#
class Requerimiento < ActiveRecord::Base
  belongs_to :solicitante, :class_name => "Usuario"
  belongs_to :empresa
  belongs_to :sector
  belongs_to :rubro
  has_many :materiales
  has_many :presupuestos

  composed_of :estado, :mapping => %w(estado codigo)

  validates_presence_of :empresa, :sector, :rubro, :solicitante

  def rechazar_por_compras!(motivo, rechazado_por)
  	if motivo.blank?
  		errors[:base] = "Debe especificar un motivo para el rechazo" and return false
  	end
  	if rechazado_por.nil?
  		errors[:base] = "Debe especificar un usuario como reposable del rechazo" and return false
  	end

		con_detalle = DetalleRechazoCompras.create(:rechazado_por => rechazado_por, :motivo => motivo)
		cambiar_estado_a Estado::RECHAZO_X_COMPRAS, con_detalle
		
		RequerimientosMailer.informar_rechazo_compras(self, rechazado_por, motivo).deliver
		self.save!
  end

  def aprobar_presupuesto_por_compras!(presupuesto, autorizante)
  	con_detalle = DetalleAprobacionCompras.create(:autorizante => autorizante, :presupuesto => presupuesto)
  	cambiar_estado_a Estado::APROBADO_X_COMPRAS, con_detalle
  	presupuesto.aprobado = true
  	presupuesto.save

		RequerimientosMailer.informar_autorizacion_compras(self, autorizante, presupuesto).deliver
		self.save!
  end

	def solicitar_aprobacion_compras!
		cambiar_estado_a Estado::PENDIENTE_APROBACION_COMPRAS
		RequerimientosMailer.solicitar_aprobacion_compras(self).deliver
		self.save!
	end

	def aprobar_por_sector!
		con_detalle = DetalleAprobacionSector.create(:autorizante => sector.responsable)
		cambiar_estado_a Estado::APROBADO_X_SECTOR, con_detalle

		RequerimientosMailer.informar_autorizacion_sector(self, sector.responsable).deliver
		self.save!
	end

	def rechazar_por_sector!(motivo)
		if motivo.blank?
			errors[:base] = "Debe especificar un motivo para el rechazo"
			return false
		end

		con_detalle = DetalleRechazoSector.create(:autorizante => sector.responsable, :motivo => motivo)
		cambiar_estado_a Estado::RECHAZO_X_SECTOR, con_detalle

		RequerimientosMailer.rqm_rechazado_por_sector(self, motivo).deliver
		self.save!
	end

	def solicitar_aprobacion_sector!
		unless sector.responsable
			errors[:base] = "El sector #{sector.nombre} aun no posee un responsable encargado. Informe al administrador de la situación y luego vuelva a intentarlo"
			return false
		end

		# Actualizar estado
		con_detalle = DetallePendienteAprobacion.create(:autorizante => sector.responsable)
		cambiar_estado_a Estado::PENDIENTE_APROBACION_SECTOR, con_detalle

		# Enviar un mail al responsable del sector
		RequerimientosMailer.solicitar_aprobacion_sector(self, sector.responsable).deliver
		self.save!
  end

	def motivo_rechazo
		estado_historico = EstadoHistorico.rechazados_del_requerimiento(self).last
		estado_historico.detalle.motivo unless estado_historico.nil? && estado_historico.detalle.nil?
	end

	def presupuesto_aprobado
		presupuestos.detect{ |p| p.aprobado } if estado == Estado::APROBADO_X_COMPRAS
	end

	private
		# TODO: Utilizar este método para evitar repeticiones
		# Cambia el estado del requerimiento y genera el historico con la información del cambio.
		# Registra los detalles del cambio
		def cambiar_estado_a(estado, detalle = nil)
			self.estado = estado
			EstadoHistorico.create(:codigo_estado => estado.codigo, :requerimiento => self, :detalle => detalle)
		end

end

