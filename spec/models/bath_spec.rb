require 'rails_helper'

RSpec.describe Bath, type: :model do
  before do
    @bath = FactoryBot.build(:bath)
  end
  describe '入浴情報の新規登録' do
    context '入浴情報の新規登録がうまくいくとき' do
      it 'bathing_id,infection_id,timing_idが存在すれば登録できる' do
        expect(@bath).to be_valid
      end
      it 'bating_idが0（未選択）以外であれば登録できる' do
        @bath.bathing_id = '1'
        expect(@bath).to be_valid
      end
      it 'infection_idが0（未選択）以外であれば登録できる' do
        @bath.infection_id = '1'
        expect(@bath).to be_valid
      end
      it 'timing_idが0(未選択)でも登録できる' do
        @bath.timing_id = '0'
        expect(@bath).to be_valid
      end
      it 'remark_bathが空でも登録できる' do
        @bath.remark_bath = ''
        expect(@bath).to be_valid
      end
    end
    context '入浴情報の新規登録がうまくいかないとき' do
      it 'bathing_idが空では登録できない' do
        @bath.bathing_id = ''
        @bath.valid?
        expect(@bath.errors.full_messages).to include("Bathing can't be blank", "Bathing can't be blank", 'Bathing の選択肢を選んでください')
      end
      it 'bathing_idが0（未選択）では登録できない' do
        @bath.bathing_id = '0'
        @bath.valid?
        expect(@bath.errors.full_messages).to include('Bathing の選択肢を選んでください')
      end
      it 'infection_idが空では登録できない' do
        @bath.infection_id = ''
        @bath.valid?
        expect(@bath.errors.full_messages).to include("Infection can't be blank", "Infection can't be blank", 'Infection の選択肢を選んでください')
      end
      it 'infection_idが0（未選択）では登録できない' do
        @bath.infection_id = '0'
        @bath.valid?
        expect(@bath.errors.full_messages).to include('Infection の選択肢を選んでください')
      end
      it 'timing_idが空では登録できない' do
        @bath.timing_id = ''
        @bath.valid?
        expect(@bath.errors.full_messages).to include("Timing can't be blank")
      end
      it 'remark_bathが20文字以上では登録できない' do
        @bath.remark_bath = '123456789012345678901'
        @bath.valid?
        expect(@bath.errors.full_messages).to include('Remark bath is too long (maximum is 20 characters)')
      end
    end
  end
end
