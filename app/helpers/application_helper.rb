module ApplicationHelper
  def flash_message
    flash.map do |key, value| 
      if key == "error"
        value += ". See below." 
        content_tag :div, value, class: "alert alert-danger" 
      else
        content_tag :div, value, class: "alert alert-success" 
      end
    end.join.html_safe
  end

end
