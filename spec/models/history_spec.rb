require 'rails_helper'

RSpec.describe History, type: :model do
  before do
    @history = FactoryBot.build(:history)
  end
  describe '更新履歴の新規登録' do
    context '更新履歴の新規登録がうまくいくとき' do
      it 'log,log_type_idが存在すれば登録できる' do
        expect(@history).to be_valid
      end
    end
    context '更新履歴の新規登録がうまくいかないとき' do
      it 'logが空では登録できない' do
        @history.log = ''
        @history.valid?
        expect(@history.errors.full_messages).to include("Log can't be blank")
      end
      it 'log_type_idが空では登録できない' do
        @history.log_type_id = ''
        @history.valid?
        expect(@history.errors.full_messages).to include("Log type can't be blank")
      end
    end
  end
end
