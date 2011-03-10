module EstadosHelper
  def estados_for_collection
    Estado.all.map { |e| e.reverse }
  end
end
