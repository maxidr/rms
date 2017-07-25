indice = 0
Requerimiento.all.each do |item|
  if item.solicitante.blank?
    indice += 1
    puts "#{item.id} #{item.solicitante_id} #{indice}"
    #if item.solicitante_id == 6
      item.solicitante_id = 39
      item.save
    #end
  end
end
