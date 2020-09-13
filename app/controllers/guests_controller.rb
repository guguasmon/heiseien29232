class GuestsController < ApplicationController
  def index
    if user_signed_in?
      user = User.find(current_user.id)
      @guests = user.guests.includes([:bath, :drink])
    end
  end

  def new
    @guest = GuestData.new
  end

  def create
    @guest = GuestData.new(guest_params)
    if @guest.valid?
      @guest.save
      flash[:notice] = '利用者情報を登録しました'
      redirect_to root_path
    else
      render('guests/new')
    end
  end

  private

  def guest_params
    params.require(:guest_data).permit(
      :first_name, :last_name, :first_name_kana, :last_name_kana, :gender_id, :visit1_id, :visit2_id, :description,
      :bathing_id, :infection_id, :timing_id, :remark_bath,
      :drink_type_id, :warm, :thickness_id, :diabetes, :remark_drink
    ).merge(user_id: current_user.id)
  end
end
