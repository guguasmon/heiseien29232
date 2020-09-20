require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe 'コメントの新規登録' do
    context 'コメントの新規登録がうまくいくとき' do
      it 'text,comment_type_idが存在すれば登録できる' do
        expect(@comment).to be_valid
      end
      it 'beforeが空でも登録できる' do
        @comment.before = ''
        expect(@comment).to be_valid
      end
      it 'afterが空でも登録できる' do
        @comment.after = ''
        expect(@comment).to be_valid
      end
    end
    context 'コメントの新規登録がうまくいかないとき' do
      it 'textが空では登録できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
      it 'comment_type_idが空では登録できない' do
        @comment.comment_type_id = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Comment type can't be blank")
      end
    end
  end
end
