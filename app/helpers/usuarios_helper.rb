module UsuariosHelper

  # De una lista de usuarios (objetos) retorna un string con el nombre y apellido de cada uno de ellos.
  # Con el siguiente formato:
  #   "Juan Martinez, Ruben Lopez y Natalia Jimenez"
  def listar_usuarios(user_list)
    user_list.map { |u| "#{u.nombre} #{u.apellido}" }.to_sentence
  end
end
