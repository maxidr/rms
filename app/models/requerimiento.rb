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
#  estado         :integer         default(0)
#
class Requerimiento < ActiveRecord::Base
  belongs_to :solicitante, :class_name => "Usuario"
  belongs_to :empresa
  belongs_to :sector
  belongs_to :rubro
  has_many :materiales
  has_many :presupuestos
  has_one :compra

  composed_of :estado, :mapping => %w(estado codigo)

  validates_presence_of :empresa, :sector, :rubro, :solicitante

  scope :para_usuario, lambda { |usuario|
    unless usuario.admin? or [Sector.compras, Sector.administracion].include? usuario.sector
      t = self.arel_table
      predicate = t[:solicitante_id].eq(usuario.id)

      sectores = Sector.with_responsable usuario
      unless sectores.empty?
        predicate = predicate.or(t[:sector_id].in(sectores.map{ |s| s.id }))
##         del_sector = where("sector_id IN (?)", sectores)
      end

      if usuario.sector.expedicion?
        predicate = predicate.or(t[:estado].eq(Estado::PENDIENTE_RECEPCION.codigo))
      end
      where(predicate)
    end
  }

  def self.propios(usr)
    arel_table[:solicitante_id].eq(usr.id)
#    where("solicitante_id = ?", usr)
  end

  def self.de_los_sectores(usr)
    sectores = Sector.with_responsable usuario
      unless sectores.empty?
        query = query.or(de_los_sectores(sectores))
      end

#      where("sector_id in (?)", sectores)
      arel_table[:sector_id].in(sectores.map{ |s| s.id })
  end

  def self.para_expedicion
#    where("estado = ?", Estado::PENDIENTE_RECEPCION.codigo)
    arel_table[:estado].eq(Estado::PENDIENTE_RECEPCION.codigo)
  end

	# Finalizar el requerimiento
	# @param [Usuario] responsable del sector que genera la finalización del requerimiento
  def finalizar!(responsable)
  	con_detalle = DetalleFinalizacion.new(:responsable => responsable)
  	cambiar_estado_a Estado::FINALIZADO, con_detalle
  end


  def rechazar_entrega!(con_detalle)
  	return false unless con_detalle.valid?
  	cambiar_estado_a Estado::CANCELADO, con_detalle
  end

  def verificar_entrega!
		cambiar_estado_a Estado::ENTREGADO
		RequerimientosMailer.informar_verificacion_entrega(self).deliver
  end

	def recepcionar!(usuario)
		con_detalle = DetalleRecepcion.new(:recepcionista => usuario)
		cambiar_estado_a Estado::PENDIENTE_VERIFICACION, con_detalle
		RequerimientosMailer.informar_recepcion(self).deliver
	end

  def realizar_compra!(compra)
		cambiar_estado_a Estado::PENDIENTE_RECEPCION
		RequerimientosMailer.informar_recepcion_pendiente(self, compra).deliver
		RequerimientosMailer.informar_prevision_pago(self, compra).deliver
  end

  def rechazar_por_compras!(motivo, rechazado_por)
  	if motivo.blank?
  		errors[:base] = "Debe especificar un motivo para el rechazo" and return false
  	end
  	if rechazado_por.nil?
  		errors[:base] = "Debe especificar un usuario como reposable del rechazo" and return false
  	end

		con_detalle = DetalleRechazoCompras.new(:rechazado_por => rechazado_por, :motivo => motivo)
		cambiar_estado_a Estado::RECHAZO_X_COMPRAS, con_detalle
		RequerimientosMailer.informar_rechazo_compras(self, rechazado_por, motivo).deliver
  end

  def aprobar_presupuesto_por_compras!(presupuesto, autorizante)
  	con_detalle = DetalleAprobacionCompras.new(:autorizante => autorizante, :presupuesto => presupuesto)

  	cambiar_estado_a(Estado::APROBADO_X_COMPRAS, con_detalle) do
    	presupuesto.aprobado = true
	  	presupuesto.save!
  	end

		RequerimientosMailer.informar_autorizacion_compras(self, autorizante, presupuesto).deliver
  end

	def solicitar_aprobacion_compras!
		cambiar_estado_a Estado::PENDIENTE_APROBACION_COMPRAS
		RequerimientosMailer.solicitar_aprobacion_compras(self).deliver
	end

	def aprobar_por_sector!(autorizante)
		con_detalle = DetalleAprobacionSector.new(:autorizante => autorizante)
		cambiar_estado_a Estado::APROBADO_X_SECTOR, con_detalle

		RequerimientosMailer.informar_autorizacion_sector(self, autorizante).deliver
	end

	def rechazar_por_sector!(motivo, autorizante)
		if motivo.blank?
			errors[:base] = "Debe especificar un motivo para el rechazo"
			return false
		end

		con_detalle = DetalleRechazoSector.new(:autorizante => autorizante, :motivo => motivo)
		cambiar_estado_a Estado::RECHAZO_X_SECTOR, con_detalle

		RequerimientosMailer.rqm_rechazado_por_sector(self, motivo).deliver

	end

	def solicitar_aprobacion_sector!
		if sector.responsables.empty?
			errors[:base] = "El sector #{sector.nombre} aun no posee un responsable encargado. Informe al administrador de la situación y luego vuelva a intentarlo"
			return false
		end

		# Actualizar estado
		cambiar_estado_a Estado::PENDIENTE_APROBACION_SECTOR

		# Enviar un mail al responsable del sector
		RequerimientosMailer.solicitar_aprobacion_sector(self).deliver
  end

	def motivo_rechazo
		estado_historico = EstadoHistorico.rechazados_del_requerimiento(self).last
		estado_historico.detalle.motivo unless estado_historico.nil? && estado_historico.detalle.nil?
	end

	def presupuesto_aprobado
		presupuestos.detect{ |p| p.aprobado } if estado >= Estado::APROBADO_X_COMPRAS
	end

	def compra_realizada?
		!compra.nil?
	end

	private

		def cambiar_estado_a(estado, detalle = nil)
			self.estado = estado
			self.transaction do
				detalle.save! unless detalle.nil?
				EstadoHistorico.create(:codigo_estado => estado.codigo, :requerimiento => self, :detalle => detalle)
				yield if block_given?
				self.save!
			end
#			self.estado = estado
#			EstadoHistorico.create(:codigo_estado => estado.codigo, :requerimiento => self, :detalle => detalle)
		end

end

