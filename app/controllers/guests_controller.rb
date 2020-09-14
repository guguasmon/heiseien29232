class GuestsController < ApplicationController
  before_action :set_guest, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, except: :index
  def index
    if user_signed_in?
      user = User.find(current_user.id)
      @guests = user.guests.includes([:bath, :drink])
    end
  end

  def new
    @guestdata = GuestData.new
  end

  def create
    @guestdata = GuestData.new(guest_params)
    if @guestdata.valid?
      @guestdata.save
      flash[:notice] = '利用者情報を登録しました'
      redirect_to root_path
    else
      render('guests/new')
    end
  end

  def destroy
    if @guest.destroy
      flash[:notice] = '利用者情報を削除しました'
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
      :first_name, :last_name, :first_name_kana, :last_name_kana, :gender_id, :visit1_id, :visit2_id, :description,
      :bathing_id, :infection_id, :timing_id, :remark_bath,
      :drink_type_id, :warm, :thickness_id, :diabetes, :remark_drink
    ).merge(id: params[:id], user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
