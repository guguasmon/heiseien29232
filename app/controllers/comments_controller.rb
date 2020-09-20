class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy, :update]
  before_action :move_to_index, except: :index

  def create
    @comment = Comment.new(comment_params)
    path_id = @comment.guest.id
    if @comment.valid?
      @comment.save
      flash[:success] = '記録をしました'
      redirect_to guest_path(path_id)
    else
      flash[:danger] = '本文を入力してください'
      redirect_to guest_path(path_id)
    end
  end

  def destroy
    path_id = @comment.guest.id
    if @comment.destroy
      flash[:danger] = '削除をしました'
      redirect_to guest_path(path_id)
    else
      redirect_to guest_path(path_id)
    end
  end

  def update
    path_id = @comment.guest.id
    if @comment.update(comment_params)
      flash[:info] = '利用者情報を更新しました'
      redirect_to guest_path(path_id)
    else
      flash[:danger] = '更新理由を入力してください'
      redirect_to guest_path(path_id)
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text, :comment_type_id).merge(user_id: current_user.id, guest_id: params[:guest_id])
  end

  def move_to_index
    unless user_signed_in?
      flash[:warning] = 'ログインしたユーザーでないと利用が認められていません'
      redirect_to root_path
    end
  end
end
