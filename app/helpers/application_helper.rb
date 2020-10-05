module ApplicationHelper
  def edit_jump(id)
    session[:bath_day].clear if session[:bath_day].present?
    session[:drink_day].clear if session[:drink_day].present?
    session[:food_day].clear if session[:food_day].present?
    id || 0
  end

  def get_url
    url = request.query_string
    number = url.slice(-1)
    number || 0
  end
end
