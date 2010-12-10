class Ability
	include	CanCan::Ability

	def initialize(usuario)
#		can :read, :all
#		cannot :write, :all
		can :edit, Requerimiento do |rqm| iniciado_or_rechazado(rqm) end
		can :add_material, Requerimiento do |rqm| iniciado_or_rechazado(rqm) end
		can :add_caracteristica, Caracteristica do |c| iniciado_or_rechazado(c.material.requerimiento) end
		can :edit_caracteristica, Caracteristica do |c| iniciado_or_rechazado(c.material.requerimiento) end
	end

	def iniciado_or_rechazado(rqm)
		rqm.estado == Requerimiento::INICIO || rqm.estado == Requerimiento::RECHAZO_X_SECTOR
	end

end

