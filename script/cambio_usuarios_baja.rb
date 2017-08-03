indice = 0
Requerimiento.all.each do |item|
  if item.solicitante.blank?
    indice += 1
    puts "#{item.id} #{item.solicitante_id} #{indice}"
    item.solicitante_id = 39
    item.save
  end
end

Requerimiento.where(:solicitante_id => 39).where('estado < 5').each do |item|
  item.estado = 10
  item.save
end
