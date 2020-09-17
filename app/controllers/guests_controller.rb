class GuestsController < ApplicationController
  before_action :set_guest, only: [:show, :destroy, :edit, :update]
  before_action :set_day_of_the_week, only: :search
  before_action :move_to_index, except: :index
  before_action :move_to_index_from_edit, only: :edit

  def index
    if user_signed_in?
      @guests = current_user.guests.includes([:bath, :drink])
      @count = @guests.size
    end
  end

  def search
    @guests = SearchGuestsService.search_guest_day(current_user.id, @day)
    # 曜日情報を入力
    day_of_the_week = %w[全 月 火 水 木 金 土 日]
    today = @day.to_i
    @day_of_the_week = day_of_the_week[today]
    # 利用者数集計
    @count = @guests.size
    # 検索結果を表示し直す
    render action: :index
  end

  def new
    @guestdata = GuestData.new
  end

  def create
    @guestdata = GuestData.new(guest_params)
    if @guestdata.valid?
      @guestdata.save
      flash[:success] = '利用者情報を登録しました'
      redirect_to root_path
    else
      render('guests/new')
    end
  end

  def destroy
    if @guest.destroy
      flash[:danger] = '利用者情報を削除しました'
      redirect_to root_path
    else
      redirect_to guest_path(@guest.id)
    end
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
      redirect_to root_path
    else
      render('guests/edit')
    end
  end

  def show
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
