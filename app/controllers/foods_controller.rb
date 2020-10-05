class FoodsController < ApplicationController
  before_action :set_day_of_the_week, only: :search
  before_action :move_to_index

  def index
    @guests = Guest.includes(:user, :food).where(users: { id: current_user.id })
    @count = @guests.size
  end

  def search
    @guests = SearchGuestsService.search_food_day(current_user.id, @day)
    # 曜日情報を入力
    day_of_the_week = %w[全 月 火 水 木 金 土 日]
    today = @day.to_i
    @day_of_the_week = day_of_the_week[today]
    # 利用者数集計
    @count = @guests.size
    # 検索結果を表示し直す
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