module ApplicationHelper
  def show_errors(error_type)
    return nil unless flash.now[error_type]
    html = "<ul>"
    flash.now[error_type].each do |error|
      html += "<li>#{h(error)}</li>"
    end
    html += "</ul>"
    html.html_safe
  end
end
