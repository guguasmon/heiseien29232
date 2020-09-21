class DrinksController < ApplicationController
  before_action :set_guest, only: [:edit, :update]
  before_action :set_day_of_the_week, only: :search
  before_action :move_to_index
  before_action :move_to_index_non_editor, only: :edit

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

  def edit
    @guestdata = GuestData.new(
      first_name: @guest.first_name,
      last_name: @guest.last_name,
      first_name_kana: @guest.first_name_kana,
      last_name_kana: @guest.last_name_kana,
      gender_id: @guest.gender_id,
      visit1_id: @guest.visit1_id,
      visit2_id: @guest.visit2_id,
      adl_id: @guest.adl_id,
      description: @guest.description,
      bathing_id: @guest.bath.bathing_id,
      infection_id: @guest.bath.infection_id,
      timing_id: @guest.bath.timing_id,
      remark_bath: @guest.bath.remark_bath,
      drink_type_id: @guest.drink.drink_type_id,
      warm: @guest.drink.warm,
      thickness_id: @guest.drink.thickness_id,
      diabetes: @guest.drink.diabetes,
      remark_drink: @guest.drink.remark_drink
    )
  end

  def update
    @guestdata = GuestData.new(guest_params)
    if @guestdata.valid?
      @guestdata.update
      flash[:info] = '利用者情報を更新しました'
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  private

  def set_guest
    @guest = Guest.find(params[:id])
  end

  def guest_params
    params.require(:guest_data).permit(
      :first_name, :last_name, :first_name_kana, :last_name_kana, :gender_id, :visit1_id, :visit2_id, :description, :adl_id,
      :bathing_id, :infection_id, :timing_id, :remark_bath,
      :drink_type_id, :warm, :thickness_id, :diabetes, :remark_drink,
      :log, :log_type_id
    ).merge(id: params[:id], user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      flash[:warning] = 'ログインしたユーザーでないと利用が認められていません'
      redirect_to root_path
    end
  end

  def move_to_index_non_editor
    unless current_user.id == @guest.user.id
      flash[:warning] = '利用者情報を登録したユーザーでないと閲覧が認められていません'
      redirect_to root_path
    end
  end

  def set_day_of_the_week
    @day = params[:id]
  end
end
