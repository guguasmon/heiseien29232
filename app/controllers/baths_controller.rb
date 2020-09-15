class BathsController < ApplicationController
  before_action :move_to_index_bath

  def index
    @guests = current_user.guests.includes(:bath)
    # user/男子/一般浴
    @females = Guest.bath_search(current_user.id, 1, 1)
  end

  private

  def move_to_index_bath
    unless user_signed_in?
      flash[:notice] = 'ログインしたユーザーでないと閲覧が認められていません'
      redirect_to root_path
    end
  end
end
