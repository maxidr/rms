# == Schema Information
# Schema version: 20101205171906
#
# Table name: usuarios
#
#  id                   :integer         not null, primary key
#  nombre               :string(255)
#  apellido             :string(255)
#  identificador        :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  rol_id								:integer

class Usuario < ActiveRecord::Base
	# FIXME: No se debe permitir que la eliminación física de los proveedores (habilitado: true, default_scope)
	validates_presence_of :nombre, :apellido, :identificador, :rol
  validates :identificador, :uniqueness => true, :length => { :minimum => 4 }

#  has_and_belongs_to_many :responsable_de, :class => "Sector"

  belongs_to :sector

  # TODO: Generar una migracion para quitar la columna roles_mask de usuarios

  ROLES = %w[operador administrador super]

	# Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  # :confirmable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :nombre, :apellido, :identificador, :email, :remember_me

  def to_s
  	nombre_completo
  end

  def nombre_completo
  	"#{nombre} #{apellido}"
  end

  def rol
  	ROLES[rol_id]
  end

  def rol=(rol)
  	idx = ROLES.index(rol.to_s.downcase)
		self.rol_id = idx unless idx.nil?
  end

  def admin?
  	ROLES[rol_id] == "administrador"
  end

  def super?
    ROLES[rol_id] == "super"
  end

end

