class Ability
	include	CanCan::Ability

	def initialize(usuario)
#		can :read, :all
#		cannot :write, :all
#   alias_action [:index, :show, :search, :recent, :popular], :to => :coolread

		can [:edit, :add_material], Requerimiento do |rqm| iniciado_or_rechazado(rqm) end
		can [:add_caracteristica, :edit_caracteristica], Caracteristica do |c| 
			iniciado_or_rechazado(c.material.requerimiento) 
		end
		
		can :aprobar_por_sector, Requerimiento do |rqm| 
			rqm.sector.responsable == usuario && rqm.estado == Requerimiento::PENDIENTE_APROBACION_SECTOR
		end
	end

	def iniciado_or_rechazado(rqm)
		rqm.estado == Requerimiento::INICIO || rqm.estado == Requerimiento::RECHAZO_X_SECTOR
	end

end

