class Ability
	include	CanCan::Ability

	def initialize(usuario)
#		can :read, :all
#		cannot :write, :all
#   alias_action [:index, :show, :search, :recent, :popular], :to => :coolread

		can [:edit, :add_material], Requerimiento do |rqm| iniciado_or_rechazado(rqm) end
		can [:add_caracteristica, :edit_caracteristica], Material do |m|
			iniciado_or_rechazado(m.requerimiento)
		end

		can :solicitar_aprobacion, Requerimiento do |rqm|
			#	Se verifica que el estado sea inicial y que se haya cargado al menos un material
			rqm.materiales.size > 0 &&
				(rqm.estado == Requerimiento::INICIO || rqm.estado == Requerimiento::RECHAZO_X_SECTOR)
		end

		can :aprobar_por_sector, Requerimiento do |rqm|
			rqm.sector.responsable == usuario && rqm.estado == Requerimiento::PENDIENTE_APROBACION_SECTOR
		end
	end

	def iniciado_or_rechazado(rqm)
		rqm.estado == Requerimiento::INICIO || rqm.estado == Requerimiento::RECHAZO_X_SECTOR
	end

end

