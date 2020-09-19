class CommentsController < ApplicationController
  before_action :set_guest, only: [:destroy, :edit, :update]
  before_action :set_comment, only: [:destroy, :edit, :update]
  before_action :move_to_index, except: :index
  before_action :move_to_index_from_edit, only: :edit


  def destroy
    path_id = @comment.guest.id
    if @comment.destroy
      flash[:danger] = '更新履歴を削除しました'
      redirect_to guest_path(path_id)
    else
      redirect_to guest_path(path_id)
    end
  end 

  def edit
  end

  def update
    binding.pry
    path_id = @comment.guest.id
    if @comment.update(comment_params)
      flash[:info] = '利用者情報を更新しました'
      redirect_to guest_path(path_id)
    else
      flash[:danger] = '理由と内容を入力してください'
      redirect_to guest_path(path_id)
    end
  end

  private
  def set_guest
    @guest = Guest.find(params[:id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
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
end