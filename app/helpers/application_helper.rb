module ApplicationHelper
  def tab(model_name, display_name = nil)
    model_name = model_name.to_s
    display_name ||= model_name.capitalize
    link = link_to display_name, url_for(:controller => model_name, :only_path => false)
    if model_name == controller_name
      item = "<li class='selected'>"
    else
      item = "<li>"
    end
    item << "#{link}</li>"
    item.html_safe
  end
end

