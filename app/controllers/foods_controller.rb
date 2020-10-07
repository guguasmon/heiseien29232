class FoodsController < ApplicationController
  before_action :set_day_of_the_week, only: :search
  before_action :move_to_index

  def index
    @p = Food.ransack(params[:q]) # 検索オブジェクトを生成
    @p.guest_user_id_eq = current_user.id # デフォルトでユーザーが管理する利用者のみを表示
    @foods = @p.result.includes([:guest, :forbids])
    @count = @foods.size
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
