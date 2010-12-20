# Fuente: http://gem-session.com/2010/03/how-to-use-the-comma-as-decimal-separator-in-rails-activerecord-columns-and-text-fields

ActionView::Helpers::FormBuilder.class_eval do

  def number_field(field, options = {})
    value = object.send(field).to_s                   
    value.gsub!('.', ',') unless value.blank?  
    options[:value] = value
    options[:class] = "#{options[:class]} number_field"
    text_field(field, options)
  end

end
