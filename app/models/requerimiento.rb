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

  FRECUENCIAS_CONSUMO = %w(eventual semanal quincenal mensual bimestral trimestral semestral anual)

  # Relations ----------------------------------------------------------------------------------------
  belongs_to :solicitante, :class_name => "Usuario"
  belongs_to :empresa
  belongs_to :sector
  belongs_to :rubro
  has_many :notificaciones

  has_many :materiales
  has_many :presupuestos do
    def aprobado
      detect{ |p| p.aprobado } if proxy_owner.estado >= Estado::APROBADO_X_COMPRAS
    end

    def seleccionado
      detect{ |p| p.seleccionado } if proxy_owner.estado >= Estado::PENDIENTE_APROBACION_COMPRAS
    end
  end

  has_one :compra

  composed_of :estado, :mapping => %w(estado codigo)

  # Validations --------------------------------------------------------------------------------------
  validates_presence_of :empresa, :sector, :rubro, :solicitante
  validates_inclusion_of :consumo, :in => FRECUENCIAS_CONSUMO

  # Callbacks ----------------------------------------------------------------------------------------
  before_create :establish_initial_state

  # Scopes -------------------------------------------------------------------------------------------

  # Busca los requerimientos por razon social del proveedor
  # en los casos de que el estado sea aprobado por compras
  # (o posterior)

  scope :by_supplier, lambda { |supplier_id|
    where("requerimientos.estado >= #{Estado::INICIO.codigo}")
    .joins(:presupuestos => :proveedor)
      .where('proveedores.id = ?', supplier_id)
  }

=begin
  scope :by_supplier, lambda { |supplier_id|
    where("requerimientos.estado >= #{Estado::APROBADO_X_COMPRAS.codigo}")
    .joins(:presupuestos => :proveedor)
      .where('proveedores.id = ?', supplier_id)
  }
=end

  # Scope para ordenar las columnas de los requerimientos en el index de requerimientos.
  scope :sort_by_empresa_asc, order('empresas.nombre ASC')
  scope :sort_by_empresa_desc, order('empresas.nombre DESC')
  scope :sort_by_solicitante_asc, order('usuarios.nombre ASC')
  scope :sort_by_solicitante_desc, order('usuarios.nombre DESC')
  scope :sort_by_sector_asc, order('sectores.nombre ASC')
  scope :sort_by_sector_desc, order('sectores.nombre DESC')
  scope :sort_by_rubro_asc, order('rubros.nombre ASC')
  scope :sort_by_rubro_desc, order('rubros.nombre DESC')
#  scope :sort_by_proveedor_asc, order('rubros.nombre ASC')
#  scope :sort_by_proveedor_desc, order('rubros.nombre DESC')

  search_methods :by_supplier

  scope :para_usuario, lambda { |usuario|
    unless usuario.admin? or [Sector.compras, Sector.administracion].include? usuario.sector
      t = self.arel_table
      predicate = t[:solicitante_id].eq(usuario.id)

      sectores = Sector.with_responsable usuario
      unless sectores.empty?
        predicate = predicate.or(t[:sector_id].in(sectores.map{ |s| s.id }))
##         del_sector = where("sector_id IN (?)", sectores)
      end

      if usuario.sector.try(:expedicion?)
#      if usuario.sector.expedicion?
        predicate = predicate.or(t[:estado].eq(Estado::PENDIENTE_RECEPCION.codigo))
      end
      where(predicate)
    end
  }

  scope :pendientes_de_aprobacion_compras, where(:estado => Estado::PENDIENTE_APROBACION_COMPRAS)

  # Methods ------------------------------------------------------------------------------------------------

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
		cambiar_estado_a(Estado::PENDIENTE_VERIFICACION, con_detalle) do
		  compra.fecha_entrega = Date.today
		  compra.save
		end
		RequerimientosMailer.informar_recepcion(self).deliver
	end

  def realizar_compra!(compra)
		cambiar_estado_a Estado::PENDIENTE_RECEPCION
		RequerimientosMailer.informar_recepcion_pendiente(self, compra).deliver
		RequerimientosMailer.informar_prevision_pago(self, compra).deliver
  end

  def realizar_pago!(pago)
    cambiar_estado_a Estado::PAGADO
    #RequerimientosMailer.informar_recepcion_pendiente(self, compra).deliver
    #RequerimientosMailer.informar_prevision_pago(self, compra).deliver
  end

  def cancelar_compra!(motivo, cancelado_por)
    con_detalle = DetalleCancelacionDeLaCompra.new(:cancelado_por => cancelado_por, :motivo => motivo)
    cambiar_estado_a Estado::PEDIDO_CANCELADO, con_detalle
  end

  def rechazar_por_compras!(motivo, rechazado_por)
  	if motivo.blank?
  		errors[:base] = "Debe especificar un motivo para el rechazo" and return false
  	end
  	if rechazado_por.nil?
  		errors[:base] = "Debe especificar un usuario como responsable del rechazo" and return false
  	end

		con_detalle = DetalleRechazoCompras.new(:rechazado_por => rechazado_por, :motivo => motivo)
		cambiar_estado_a Estado::RECHAZO_X_COMPRAS, con_detalle
		RequerimientosMailer.informar_rechazo_compras(self, rechazado_por, motivo).deliver
  end

  # El requerimiento puede ser cancelado por compras una vez aprobado (por compras tambien).
  # Suele aplicarse a los casos en que luego de aprobado se determina que existe una mejor oferta
  # o se quiere comprar en otras condiciones (solicitado por Emilio el 30/01/2013)
  def cancelar_por_compras!(cancelado_por)
    con_detalle = DetalleCancelacionCompras.new(:cancelado_por => cancelado_por)
    cambiar_estado_a Estado::CANCELADO_POR_COMPRAS, con_detalle
  end

  def aprobar_presupuesto_por_compras!(presupuesto, autorizante = nil)


    detalle = DetalleVerificacionCompras.para_el_presupuesto(presupuesto)
    detalle.aprobar_por(autorizante) if autorizante

    responsables_de_compras = Sector.compras.responsables
    logger.debug  "---------------> Aprobar presupuesto #{presupuesto.id} del requerimiento: #{id}"
    if detalle.aprobacion_finalizada?(responsables_de_compras)
      cambiar_estado_a(Estado::APROBADO_X_COMPRAS, detalle) do
        presupuesto.aprobado = true
        presupuesto.valid?
        logger.debug "------------> #{presupuesto.errors}"
        presupuesto.save!
      end
    end
  end

  #def aprobar_presupuesto_por_compras!(presupuesto, autorizante)
  #	con_detalle = DetalleAprobacionCompras.new(:autorizante => autorizante, :presupuesto => presupuesto)

  #	cambiar_estado_a(Estado::APROBADO_X_COMPRAS, con_detalle) do
  #  	presupuesto.aprobado = true
	#  	presupuesto.save!
  #	end

	#	RequerimientosMailer.informar_autorizacion_compras(self, autorizante, presupuesto).deliver
  #end

	def solicitar_aprobacion_compras!
		cambiar_estado_a Estado::PENDIENTE_APROBACION_COMPRAS
		RequerimientosMailer.solicitar_aprobacion_compras(self).deliver
	end

	def aprobar_por_sector!(autorizante)
		con_detalle = DetalleAprobacionSector.new(:autorizante => autorizante)
		# cambiar_estado_a Estado::APROBADO_X_SECTOR, con_detalle

    cambiar_estado_a Estado::PENDIENTE_APROBACION_COMPRAS
		RequerimientosMailer.informar_autorizacion_sector(self, autorizante).deliver
	end

  def informar_notificacion( usuario )
    RequerimientosMailer.informar_notificacion(self, self.solicitante).deliver

    if usuario.email != self.solicitante.email
      RequerimientosMailer.informar_notificacion(self, usuario).deliver
    end
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

#	def presupuesto_aprobado
#		presupuestos.detect{ |p| p.aprobado } if estado >= Estado::APROBADO_X_COMPRAS
#	end

	def compra_realizada?
		!compra.nil?
	end

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

  def proveedores
    presupuestos.map { |presupuesto| presupuesto.proveedor.razon_social }
  end

  private
  def establish_initial_state
    self.estado = Estado::APROBADO_X_SECTOR if sector.responsables.include?(solicitante)
  end
end
