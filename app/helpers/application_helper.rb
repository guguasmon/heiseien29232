module ApplicationHelper
  def edit_jump(id)
    session[:bath_day].clear if session[:bath_day].present?
    session[:drink_day].clear if session[:drink_day].present?
    session[:food_day].clear if session[:food_day].present?
    if id
      return id
    else
      return 0
    end
  end
end
