require 'rails_helper'

RSpec.describe Drink, type: :model do
  before do
    @drink = FactoryBot.build(:drink)
  end
  describe '水分情報の新規登録' do
    context '水分情報の新規登録がうまくいくとき' do
      it 'drink_type_id,thickness_id,warm,diabetesが存在すれば登録できる' do
        expect(@drink).to be_valid
      end
      it 'drink_type_idが0（未選択）以外であれば登録できる' do
        @drink.drink_type_id = '1'
        expect(@drink).to be_valid
      end
      it 'thickness_idが0（未選択）以外であれば登録できる' do
        @drink.thickness_id = '1'
        expect(@drink).to be_valid
      end
      it 'remark_drinkが空でも登録できる' do
        @drink.remark_drink = ''
        expect(@drink).to be_valid
      end
    end

    context '水分情報の新規登録がうまくいかないとき' do
      it 'drink_type_idが空では登録できない' do
        @drink.drink_type_id = ''
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Drink type can't be blank", "Drink type can't be blank", 'Drink type の選択肢を選んでください')
      end
      it 'drink_type_idが0（未選択）では登録できない' do
        @drink.drink_type_id = '0'
        @drink.valid?
        expect(@drink.errors.full_messages).to include('Drink type の選択肢を選んでください')
      end
      it 'thickness_idが空では登録できない' do
        @drink.thickness_id = ''
        @drink.valid?
        expect(@drink.errors.full_messages).to include("Thickness can't be blank", "Thickness can't be blank", 'Thickness の選択肢を選んでください')
      end
      it 'thickness_idが0（未選択）では登録できない' do
        @drink.thickness_id = '0'
        @drink.valid?
        expect(@drink.errors.full_messages).to include('Thickness の選択肢を選んでください')
      end
      it 'warmが空では登録できない' do
        @drink.warm = nil
        @drink.valid?
        expect(@drink.errors.full_messages).to include('Warm is not included in the list')
      end
      it 'diabetesが空では登録できない' do
        @drink.diabetes = nil
        @drink.valid?
        expect(@drink.errors.full_messages).to include('Diabetes is not included in the list')
      end
      it 'remark_drinkが20文字以上では登録できない' do
        @drink.remark_drink = '123456789012345678901'
        @drink.valid?
        expect(@drink.errors.full_messages).to include('Remark drink is too long (maximum is 20 characters)')
      end
    end
  end
end
