# Fuente: http://gem-session.com/2010/03/how-to-use-the-comma-as-decimal-separator-in-rails-activerecord-columns-and-text-fields

ActiveRecord::Base.class_eval do

  def convert_number_column_value_with_comma_separator(value)
    value = convert_number_column_value_without_comma_separator(value)
    if value.is_a?(String)
      value = value.gsub(',', '.')
    end
    value
  end

  alias_method_chain :convert_number_column_value, :comma_separator

end

ActiveRecord::ConnectionAdapters::Column.class_eval do

  def type_cast_with_comma_separator(value)
    if type == :decimal && value.is_a?(String)
      value = value.gsub(',', '.')
    end
    type_cast_without_comma_separator(value)
  end

  alias_method_chain :type_cast, :comma_separator

end
