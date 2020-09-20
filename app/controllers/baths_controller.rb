class BathsController < ApplicationController
  before_action :set_guest, only: [:edit, :update]
  before_action :set_day_of_the_week, only: :search
  before_action :move_to_index
  before_action :move_to_index_from_edit, only: :edit

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
      :text, :comment_type_id
    ).merge(id: params[:id], user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      flash[:warning] = 'ログインしたユーザーでないと利用が認められていません'
      redirect_to root_path
    end
  end

  def move_to_index_from_edit
    unless current_user.id == @guest.user.id
      flash[:warning] = '利用者情報を登録したユーザーでないと閲覧が認められていません'
      redirect_to root_path
    end
  end

  def set_day_of_the_week
    @day = params[:id]
  end
end
