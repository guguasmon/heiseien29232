class DrinksController < ApplicationController
  before_action :move_to_index_drink
  before_action :set_drink, only: [:edit, :update]

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
  end

  def update
    if @drink.update(drink_params)
      flash[:notice] = '水分詳細情報を更新しました'
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  private

  def drink_params
    params.require(:drink).permit(:drink_type_id, :thickness_id, :warm, :diabetes, :remark_drink)
  end

  def set_drink
    @drink = Drink.find(params[:id])
  end

  def move_to_index_drink
    unless user_signed_in?
      flash[:notice] = 'ログインしたユーザーでないと閲覧が認められていません'
      redirect_to root_path
    end
  end
end
