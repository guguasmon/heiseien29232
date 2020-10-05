class DrinksController < ApplicationController
  before_action :set_day_of_the_week, only: :search
  before_action :move_to_index

  def index
    # 牛乳
    @milk_guests = SearchGuestsService.search_drink(current_user.id, 1)
    # コーヒー牛乳
    @coffee_milk_guests = SearchGuestsService.search_drink(current_user.id, 2)
    # ヤクルト
    @yakult_guests = SearchGuestsService.search_drink(current_user.id, 3)
    # ジュース
    @juice_guests = SearchGuestsService.search_drink(current_user.id, 4)
    # プリン
    @pudding_guests = SearchGuestsService.search_drink(current_user.id, 5)
    # ヨーグルト
    @yogurt_guests = SearchGuestsService.search_drink(current_user.id, 6)
    # 牛乳ゼリー
    @milk_jelly_guests = SearchGuestsService.search_drink(current_user.id, 7)
    # お茶
    @tea_guests = SearchGuestsService.search_drink(current_user.id, 8)
    @guests = Guest.includes(:user, :drink).where(users: { id: current_user.id })
    @count = @guests.size
  end

  def search
    # 牛乳
    @milk_guests = SearchGuestsService.search_drink_day(current_user.id, 1, @day)
    # コーヒー牛乳
    @coffee_milk_guests = SearchGuestsService.search_drink_day(current_user.id, 2, @day)
    # ヤクルト
    @yakult_guests = SearchGuestsService.search_drink_day(current_user.id, 3, @day)
    # ジュース
    @juice_guests = SearchGuestsService.search_drink_day(current_user.id, 4, @day)
    # プリン
    @pudding_guests = SearchGuestsService.search_drink_day(current_user.id, 5, @day)
    # ヨーグルト
    @yogurt_guests = SearchGuestsService.search_drink_day(current_user.id, 6, @day)
    # 牛乳ゼリー
    @milk_jelly_guests = SearchGuestsService.search_drink_day(current_user.id, 7, @day)
    # お茶
    @tea_guests = SearchGuestsService.search_drink_day(current_user.id, 8, @day)
    # 曜日情報を入力
    day_of_the_week = %w[全 月 火 水 木 金 土 日]
    today = @day.to_i
    @day_of_the_week = day_of_the_week[today]
    # 利用者数を集計
    count = 0
    count += @milk_guests.size
    count += @coffee_milk_guests.size
    count += @yakult_guests.size
    count += @juice_guests.size
    count += @pudding_guests.size
    count += @yogurt_guests.size
    count += @milk_jelly_guests.size
    count += @tea_guests.size
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
