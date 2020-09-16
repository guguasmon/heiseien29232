class DrinksController < ApplicationController
  before_action :move_to_index_drink
  before_action :set_guest, only: [:edit, :update]

  def index
    @guests = current_user.guests.includes(:bath)
    # 牛乳
    @milk_guests = Guest.drink_search(current_user.id, 1)
    # コーヒー牛乳
    @coffee_milk_guests = Guest.drink_search(current_user.id, 2)
    # ヤクルト
    @yakult_guests = Guest.drink_search(current_user.id, 3)
    # ジュース
    @juice_guests = Guest.drink_search(current_user.id, 4)
    # プリン
    @pudding_guests = Guest.drink_search(current_user.id, 5)
    # ヨーグルト
    @yogurt_guests = Guest.drink_search(current_user.id, 6)
    # 牛乳ゼリー
    @milk_jelly_guests = Guest.drink_search(current_user.id, 7)
    # お茶
    @tea_guests = Guest.drink_search(current_user.id, 8)
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
      flash[:notice] = '利用者情報を更新しました'
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
      :drink_type_id, :warm, :thickness_id, :diabetes, :remark_drink
    ).merge(id: params[:id], user_id: current_user.id)
  end

  def move_to_index_drink
    unless user_signed_in?
      flash[:notice] = 'ログインしたユーザーでないと閲覧が認められていません'
      redirect_to root_path
    end
  end
end
