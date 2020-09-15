class BathsController < ApplicationController
  before_action :move_to_index_bath

  def index
    @guests = current_user.guests.includes(:bath)
    # user/男子/一般浴
    @normal_males = Guest.bath_search(current_user.id, 1, 1)
    # user/女子/一般浴
    @normal_females = Guest.bath_search(current_user.id, 2, 1)
    # user/男子/一般チェアー浴
    @normal_chair_males = Guest.bath_search(current_user.id, 1, 2)
    # user/女子/一般チェアー浴
    @normal_chair_females = Guest.bath_search(current_user.id, 2, 2)
    # user/男子/チェアー浴
    @chair_males = Guest.bath_search(current_user.id, 1, 3)
    # user/女子/チェアー浴
    @chair_females = Guest.bath_search(current_user.id, 2, 3)
  end

  private

  def move_to_index_bath
    unless user_signed_in?
      flash[:notice] = 'ログインしたユーザーでないと閲覧が認められていません'
      redirect_to root_path
    end
  end
end
