class GuestsController < ApplicationController
  before_action :set_guest, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, except: :index
  before_action :move_to_index_non_editor, only: [:edit, :show]
  before_action :lookup_guest, only: [:index, :lookup]

  def index
    if user_signed_in?
      @guests = @p.result.includes([:bath, :drink, :food])
      @count = @guests.size
    end
  end

  def lookup
    @guests = @p.result.includes([:bath, :drink, :food]) # 検索条件にマッチした利用者の情報を取得
    @count = @guests.size
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
    session[:bath_day] = params[:bath_day] if params[:bath_day].present?
    session[:drink_day] = params[:drink_day] if params[:drink_day].present?
    session[:food_day] = params[:food_day] if params[:food_day].present?
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
      remark_drink: @guest.drink.remark_drink,
      staple_type_id: @guest.food.staple_type_id,
      staple_amount_id: @guest.food.staple_amount_id,
      main_dish_type_id: @guest.food.main_dish_type_id,
      main_dish_amount_id: @guest.food.main_dish_amount_id,
      side_dish_type_id: @guest.food.side_dish_type_id,
      side_dish_amount_id: @guest.food.side_dish_amount_id,
      banned_food: @guest.food.banned_food,
      low_salt: @guest.food.low_salt,
      soup_thick: @guest.food.soup_thick,
      denture_id: @guest.food.denture_id,
      remark_food: @guest.food.remark_food
    )
  end

  def update
    @guestdata = GuestData.new(guest_params)
    if @guestdata.valid?
      @guestdata.update
      if guest_params[:image].present?
        @guest.update(image: guest_params[:image]) if @guest.valid?
      end
      flash[:info] = '利用者情報を更新しました'
      if session[:bath_day].present?
        if session[:bath_day] == '0'
          redirect_to baths_path
        else
          redirect_to search_bath_path(session[:bath_day])
        end
        session[:bath_day].clear
      elsif session[:drink_day].present?
        if session[:drink_day] == '0'
          redirect_to drinks_path
        else
          redirect_to search_drink_path(session[:drink_day])
        end
        session[:drink_day].clear
      elsif session[:food_day].present?
        if session[:food_day] == '0'
          redirect_to foods_path
        else
          redirect_to foods_path(q: {g: {'1': {m: 'or', visit1_id_eq: session[:food_day], visit2_id_eq: session[:food_day]}, '0': {user_id_eq: "#{current_user.id}"}}})
        end
        session[:food_day].clear
      else
        redirect_to action: :show
      end
    else
      render('guests/edit')
    end
  end

  def show
    @comment_new = Comment.new
    @comments = Comment.joins(:guest).where(guests: { id: @guest.id }).order('created_at ASC')
    @histories = History.joins(:guest).where(guests: { id: @guest.id }).order('created_at ASC')
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
      :log, :log_type_id,
      :image,
      :staple_type_id, :staple_amount_id, :main_dish_type_id, :main_dish_amount_id, :side_dish_type_id, :side_dish_amount_id,
      :banned_food, :low_salt, :soup_thick, :denture_id, :remark_food
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

  def lookup_guest
    @p = Guest.ransack(params[:q]) # 検索オブジェクトを生成
    if user_signed_in?
      @p.user_id_eq = current_user.id # デフォルトでユーザーが管理する利用者のみを表示
    end
  end
end
