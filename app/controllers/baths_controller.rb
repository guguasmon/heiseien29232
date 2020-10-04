class BathsController < ApplicationController
  before_action :set_day_of_the_week, only: :search
  before_action :move_to_index

  def index
    # user/男子/一般浴
    @normal_males = SearchGuestsService.search_bath(current_user.id, 1, 1)
    # user/女子/一般浴
    @normal_females = SearchGuestsService.search_bath(current_user.id, 2, 1)
    # user/男子/一般チェアー浴
    @normal_chair_males = SearchGuestsService.search_bath(current_user.id, 1, 2)
    # user/女子/一般チェアー浴
    @normal_chair_females = SearchGuestsService.search_bath(current_user.id, 2, 2)
    # user/男子/チェアー浴
    @chair_males = SearchGuestsService.search_bath(current_user.id, 1, 3)
    # user/女子/チェアー浴
    @chair_females = SearchGuestsService.search_bath(current_user.id, 2, 3)
  end

  def search
    # user/男子/一般浴
    @normal_males = SearchGuestsService.search_bath_day(current_user.id, 1, 1, @day)
    # user/女子/一般浴
    @normal_females = SearchGuestsService.search_bath_day(current_user.id, 2, 1, @day)
    # user/男子/一般チェアー浴
    @normal_chair_males = SearchGuestsService.search_bath_day(current_user.id, 1, 2, @day)
    # user/女子/一般チェアー浴
    @normal_chair_females = SearchGuestsService.search_bath_day(current_user.id, 2, 2, @day)
    # user/男子/チェアー浴
    @chair_males = SearchGuestsService.search_bath_day(current_user.id, 1, 3, @day)
    # user/女子/チェアー浴
    @chair_females = SearchGuestsService.search_bath_day(current_user.id, 2, 3, @day)
    # 曜日情報を入力
    day_of_the_week = %w[全 月 火 水 木 金 土 日]
    today = @day.to_i
    @day_of_the_week = day_of_the_week[today]
    # 利用者数を集計
    count = 0
    count += @normal_males.size
    count += @normal_females.size
    count += @normal_chair_males.size
    count += @normal_chair_females.size
    count += @chair_males.size
    count += @chair_females.size
    @count = count
    render action: :index
  end


  private

  def move_to_index
    unless user_signed_in?
      flash[:warning] = 'ログインしたユーザーでないと利用が認められていません'
      redirect_to root_path
    end
  end

  def set_day_of_the_week
    @day = params[:id]
  end
end
