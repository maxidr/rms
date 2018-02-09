class Ability
	include	CanCan::Ability

	def initialize(usuario)
#		can :read, :all
#		cannot :write, :all
#   alias_action [:index, :show, :search, :recent, :popular], :to => :coolread
    return false if usuario.nil?

		@compras ||= Sector.compras

		if usuario.admin?
			can :manage, [Sector, Rubro, Empresa, Proveedor, Moneda, CondicionPago, Usuario]
			can :enable, Sector
      can [:read, :destroy], Attachment
		end

		can [:edit, :add_material, :add_attachment], Requerimiento do |rqm|
      # El que puede agregar materiales es el solicitante, cuando:
      # el requerimiento está en estado iniciado o rechazado por el sector
      # o cuando está en estado aprobado por el sector y el solicitante es responsable de dicho sector
      rqm.solicitante == usuario &&
        ( iniciado_or_rechazado(rqm) ||
         (rqm.estado == Estado::APROBADO_X_SECTOR && rqm.sector.responsables.include?(rqm.solicitante) ))
		end

    #can [:edit, :add_attachment], Presupuesto do |pres|
    #end

    #can :edit_only_details, Material do |material|
    #  iniciado_or_rechazado(material.requerimiento)
    #end

    # El material se puede modificar en cualquier momento. Si el pedido no se encuentra
    # en estado iniciado o rechazado entonces solo se puede editar el detalle.
    can [:edit, :update], Material do |material|
      true
    end

    can :destroy, Material do |material|
      can? :edit, material.requerimiento
    end

		can [:add_caracteristica, :edit_caracteristica, :edit_only_details], Material do |m|
      #can?(:add_material, m.requerimiento)
      rqm = m.requerimiento
      iniciado_or_rechazado(rqm) ||
        ( rqm.estado == Estado::APROBADO_X_SECTOR && rqm.sector.responsables.include?(rqm.solicitante) )
			#iniciado_or_rechazado(m.requerimiento)
		end

		can :solicitar_aprobacion, Requerimiento do |rqm|
			#	Se verifica que el estado sea inicial y que se haya cargado al menos un material
			rqm.materiales.size > 0 && rqm.solicitante == usuario	&& iniciado_or_rechazado(rqm)
		end

		can :aprobar_por_sector, Requerimiento do |rqm|
		  rqm.sector.responsables.exists?(usuario) && rqm.estado == Estado::PENDIENTE_APROBACION_SECTOR
		end

		can :solicitar_aprobacion_compras, Requerimiento do |rqm|
			rqm.solicitante == usuario && rqm.estado.in?(Estado::APROBADO_X_SECTOR, Estado::RECHAZO_X_COMPRAS)
		end

		can :rechazar_por_compras, Requerimiento do |rqm|
      rqm.estado == Estado::PENDIENTE_APROBACION_COMPRAS &&
        @compras.responsables.include?(usuario) &&
        no_fue_verificado_por_usuario?(rqm, usuario)
    end

    # Compras puede cancelar un requerimiento luego de aprobarlo (o incluso antes de ello)
    can :cancelar_requerimiento, Requerimiento do |rqm|
      rqm.estado.in?(Estado::PENDIENTE_APROBACION_COMPRAS, Estado::APROBADO_X_COMPRAS) &&
      @compras.responsables.include?(usuario)
    end

		can :gestionar_presupuesto, Requerimiento do |rqm|
			if rqm.estado == Estado::PENDIENTE_APROBACION_COMPRAS
				@compras.responsables.include?(usuario)
			else
				rqm.estado.in? Estado::INICIO, Estado::RECHAZO_X_SECTOR, Estado::PENDIENTE_APROBACION_SECTOR, Estado::APROBADO_X_SECTOR, Estado::RECHAZO_X_COMPRAS
			end
		end

		can :aprobar_presupuestos, Requerimiento do |rqm|
			rqm.estado == Estado::PENDIENTE_APROBACION_COMPRAS &&
        @compras.responsables.include?(usuario) &&
        no_fue_verificado_por_usuario?(rqm, usuario)
        #usuario.sector == @compras
		end

    can :aprobar_presupuesto_seleccionado, Requerimiento do |rqm|
      rqm.presupuestos.seleccionado &&
      can?(:aprobar_presupuestos, rqm) &&
      no_fue_verificado_por_usuario?(rqm, usuario)
    end

    can :cancelar_compra, Requerimiento do |rqm|
      rqm.solicitante == usuario &&
        rqm.estado.in?(Estado::PENDIENTE_RECEPCION, Estado::APROBADO_X_COMPRAS)
    end

		can :comprar, Requerimiento, :solicitante => usuario, :estado => Estado::APROBADO_X_COMPRAS

    can :pagar, Requerimiento do |rqm|
      estados = [
        Estado::PENDIENTE_RECEPCION,
        Estado::PENDIENTE_VERIFICACION,
        Estado::ENTREGADO,
        Estado::FINALIZADO
      ]
      rqm.estado.in? estados
    end

		#	El usuario que no es administrador puede modificar solos sus datos

		can [:edit, :update, :show], Usuario, :identificador => usuario.identificador

		# Solo los administradores puede modificar su rol o sector, o el de otros usuarios
		can :change_rol_and_sector, Usuario, :admin? => true

    can :destroy, Requerimiento do |rqm|
      rqm.estado == Estado::INICIO and (usuario.admin? or rqm.solicitante == usuario )
    end

		can :recepcionar, Requerimiento do |rqm|
			unless usuario.sector.nil?
				usuario.sector.expedicion? and rqm.estado == Estado::PENDIENTE_RECEPCION
			end
		end

		can :verificar_entrega, Requerimiento do |rqm|
			rqm.estado == Estado::PENDIENTE_VERIFICACION and usuario == rqm.solicitante
		end

		can :rechazar_entrega, Requerimiento do |rqm|
			rqm.estado == Estado::PENDIENTE_VERIFICACION and usuario == rqm.solicitante
		end

		can :finalizar, Requerimiento do |rqm|
			rqm.estado == Estado::ENTREGADO and (Sector.compras.responsable? usuario)
		end

		can :generar_reporte, Requerimiento do |rqm|
      estados = [
        Estado::APROBADO_X_COMPRAS,
        Estado::PENDIENTE_RECEPCION,
        Estado::PENDIENTE_VERIFICACION,
        Estado::ENTREGADO,
        Estado::FINALIZADO,
        Estado::CANCELADO_POR_COMPRAS,
        Estado::PEDIDO_CANCELADO
      ]
		  rqm.estado.in? estados
    end

	end

	def iniciado_or_rechazado(rqm)
		rqm.estado.in?(Estado::INICIO, Estado::RECHAZO_X_SECTOR)
	end

  def verificadores_de_presupuesto(rqm)
    return [] unless rqm.presupuestos && rqm.presupuestos.seleccionado
    seleccionado = rqm.presupuestos.seleccionado
    seleccionado.verificaciones.verificadores
  end

  def no_fue_verificado_por_usuario?(rqm, usuario)
    (@compras.responsables - verificadores_de_presupuesto(rqm)).include?(usuario)
  end
end

