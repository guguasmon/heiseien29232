require 'rails_helper'

RSpec.describe Food, type: :model do
  before do
    @food = FactoryBot.build(:food)
  end
  describe '食事情報の新規登録' do
    context '食事情報の新規登録がうまくいくとき' do
      it 'staple_type_id,staple_amount_id,main_dish_type_id,main_dish_amount_id,side_dish_type_id,side_dish_amount_id,low_salt,soup_thick,denture_idが存在すれば登録できる' do
        expect(@food).to be_valid
      end
      it 'staple_type_idが0（未選択）以外であれば登録できる' do
        @food.staple_type_id = '1'
        expect(@food).to be_valid
      end
      it 'main_dish_type_idが0（未選択）以外であれば登録できる' do
        @food.main_dish_type_id = '1'
        expect(@food).to be_valid
      end
      it 'side_dish_type_idが0（未選択）以外であれば登録できる' do
        @food.side_dish_type_id = '1'
        expect(@food).to be_valid
      end
      it 'denture_idが0（未選択）以外であれば登録できる' do
        @food.denture_id = '1'
        expect(@food).to be_valid
      end
      it 'remark_foodが空でも登録できる' do
        @food.remark_food = ''
        expect(@food).to be_valid
      end
    end

    context '食事情報の新規登録がうまくいかないとき' do
      it 'staple_type_idが空では登録できない' do
        @food.staple_type_id = ''
        @food.valid?
        expect(@food.errors.full_messages).to include("Staple type can't be blank", "Staple type can't be blank", 'Staple type の選択肢を選んでください')
      end
      it 'staple_type_idが0（未選択）では登録できない' do
        @food.staple_type_id = '0'
        @food.valid?
        expect(@food.errors.full_messages).to include('Staple type の選択肢を選んでください')
      end
      it 'staple_amount_idが空では登録できない' do
        @food.staple_amount_id = ''
        @food.valid?
        expect(@food.errors.full_messages).to include("Staple amount can't be blank")
      end
      it 'main_dish_type_idが空では登録できない' do
        @food.main_dish_type_id = ''
        @food.valid?
        expect(@food.errors.full_messages).to include("Main dish type can't be blank", "Main dish type can't be blank", 'Main dish type の選択肢を選んでください')
      end
      it 'main_dish_type_idが0（未選択）では登録できない' do
        @food.main_dish_type_id = '0'
        @food.valid?
        expect(@food.errors.full_messages).to include('Main dish type の選択肢を選んでください')
      end
      it 'main_dish_amount_idが空では登録できない' do
        @food.main_dish_amount_id = ''
        @food.valid?
        expect(@food.errors.full_messages).to include("Main dish amount can't be blank")
      end
      it 'side_dish_type_idが空では登録できない' do
        @food.side_dish_type_id = ''
        @food.valid?
        expect(@food.errors.full_messages).to include("Side dish type can't be blank", "Side dish type can't be blank", 'Side dish type の選択肢を選んでください')
      end
      it 'side_dish_type_idが0（未選択）では登録できない' do
        @food.side_dish_type_id = '0'
        @food.valid?
        expect(@food.errors.full_messages).to include('Side dish type の選択肢を選んでください')
      end
      it 'side_dish_amount_idが空では登録できない' do
        @food.side_dish_amount_id = ''
        @food.valid?
        expect(@food.errors.full_messages).to include("Side dish amount can't be blank")
      end
      it 'denture_idが空では登録できない' do
        @food.denture_id = ''
        @food.valid?
        expect(@food.errors.full_messages).to include("Denture can't be blank", "Denture can't be blank", 'Denture の選択肢を選んでください')
      end
      it 'denture_idが0（未選択）では登録できない' do
        @food.denture_id = '0'
        @food.valid?
        expect(@food.errors.full_messages).to include('Denture の選択肢を選んでください')
      end
      it 'low_saltが空では登録できない' do
        @food.low_salt = nil
        @food.valid?
        expect(@food.errors.full_messages).to include('Low salt is not included in the list')
      end
      it 'soup_thickが空では登録できない' do
        @food.soup_thick = nil
        @food.valid?
        expect(@food.errors.full_messages).to include('Soup thick is not included in the list')
      end
      it 'remark_foodが20文字以上では登録できない' do
        @food.remark_food = '123456789012345678901'
        @food.valid?
        expect(@food.errors.full_messages).to include('Remark food is too long (maximum is 20 characters)')
      end
    end
  end
end
