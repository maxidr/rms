class Ability
	include	CanCan::Ability

	def initialize(usuario)
#		can :read, :all
#		cannot :write, :all
#   alias_action [:index, :show, :search, :recent, :popular], :to => :coolread
		@compras ||= Sector.compras.first

		can [:edit, :add_material], Requerimiento do |rqm| iniciado_or_rechazado(rqm) end
		can [:add_caracteristica, :edit_caracteristica], Material do |m|
			iniciado_or_rechazado(m.requerimiento)
		end

		can :solicitar_aprobacion, Requerimiento do |rqm|
			#	Se verifica que el estado sea inicial y que se haya cargado al menos un material
			rqm.materiales.size > 0 && rqm.solicitante == usuario	&& iniciado_or_rechazado(rqm)
		end
		
		can :aprobar_por_sector, Requerimiento do |rqm|
			rqm.sector.responsable == usuario && rqm.estado == Estado::PENDIENTE_APROBACION_SECTOR
		end		

#		can :solicitar_aprobacion_compras, Requerimiento, :solicitante => usuario,
#			:estado => Estado::APROBADO_X_SECTOR, :estado => Estado::RECHAZO_X_COMPRAS

		can :solicitar_aprobacion_compras, Requerimiento do |rqm|
			rqm.solicitante == usuario && rqm.estado.in?(Estado::APROBADO_X_SECTOR, Estado::RECHAZO_X_COMPRAS)
		end

		can :rechazar_por_compras, Requerimiento do |rqm|
			usuario.sector == @compras && rqm.estado == Estado::PENDIENTE_APROBACION_COMPRAS
		end

		can :gestionar_presupuesto, Requerimiento do |rqm|
			puts "Sector usuario: #{usuario.sector}"
			puts "Compras: #{@compras}"

			if rqm.estado == Estado::PENDIENTE_APROBACION_COMPRAS
				false if usuario.sector == nil
				usuario.sector == @compras
			else
				rqm.estado.in? Estado::INICIO, Estado::RECHAZO_X_SECTOR, Estado::PENDIENTE_APROBACION_SECTOR, Estado::APROBADO_X_SECTOR
			end
		end

		can :aprobar_presupuestos, Requerimiento do |rqm|
			rqm.estado == Estado::PENDIENTE_APROBACION_COMPRAS && usuario.sector == @compras
		end
		
		can :comprar, Requerimiento, :solicitante => usuario, :estado => Estado::APROBADO_X_COMPRAS

	end

	def iniciado_or_rechazado(rqm)
		rqm.estado.in?(Estado::INICIO, Estado::RECHAZO_X_SECTOR)
	end

end

