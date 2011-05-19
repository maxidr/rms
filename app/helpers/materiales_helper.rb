module MaterialesHelper
  
  def filtered_input_params(material)
    if action_name == 'edit' and cannot?(:edit_only_details, material)
      params = { :input_html => { :disabled => true }, :hint => 'No puede modificar este campo' }
    else        
      params = {}
    end
  end

end
