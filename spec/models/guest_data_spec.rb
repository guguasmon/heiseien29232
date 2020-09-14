require 'rails_helper'

RSpec.describe GuestData, type: :model do
  before do
    @guestdata = FactoryBot.build(:guest_data)
  end
  describe '利用者一括新規登録' do
    context '一括新規登録がうまくいくとき' do
      it 'first_name,last_name,first_name_kana,last_name_kana,gender_id,visit1_id,visit2_id,adl_id,bathing_id,infection_id,timing_id,drink_type_id,thickness_id,warm,diabetesが存在すれば登録できる' do
        expect(@guestdata).to be_valid
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @guestdata.first_name = '漢字ひらがなカタカナ'
        expect(@guestdata).to be_valid
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @guestdata.last_name = '漢字ひらがなカタカナ'
        expect(@guestdata).to be_valid
      end
      it 'first_name_kanaが全角（カタカナ）であれば登録できる' do
        @guestdata.first_name_kana = 'カタカナ'
        expect(@guestdata).to be_valid
      end
      it 'last_name_kanaが全角（カタカナ）であれば登録できる' do
        @guestdata.last_name_kana = 'カタカナ'
        expect(@guestdata).to be_valid
      end
      it 'gender_idが１か２であれば登録できる' do
        @guestdata.gender_id = '1'
        expect(@guestdata).to be_valid
      end
      it 'gender_idが１か２であれば登録できる' do
        @guestdata.gender_id = '2'
        expect(@guestdata).to be_valid
      end
      it 'visit1_idがあれば登録できる' do
        @guestdata.visit1_id = '1'
        expect(@guestdata).to be_valid
      end
      it 'visit2_idがあれば登録できる' do
        @guestdata.visit2_id = '1'
        expect(@guestdata).to be_valid
      end
      it 'visit2_idが0(未選択)でも登録できる' do
        @guestdata.visit2_id = '0'
        expect(@guestdata).to be_valid
      end
      it 'adl_idがあれば登録できる' do
        @guestdata.adl_id = '1'
        expect(@guestdata).to be_valid
      end
      it 'descriptionが空でも登録できる' do
        @guestdata.description = ''
        expect(@guestdata).to be_valid
      end
      it 'bating_idが0（未選択）以外であれば登録できる' do
        @guestdata.bathing_id = '1'
        expect(@guestdata).to be_valid
      end
      it 'infection_idが0（未選択）以外であれば登録できる' do
        @guestdata.infection_id = '1'
        expect(@guestdata).to be_valid
      end
      it 'timing_idが0(未選択)でも登録できる' do
        @guestdata.timing_id = '0'
        expect(@guestdata).to be_valid
      end
      it 'remark_bathが空でも登録できる' do
        @guestdata.remark_bath = ''
        expect(@guestdata).to be_valid
      end
      it 'drink_type_idが0（未選択）以外であれば登録できる' do
        @guestdata.drink_type_id = '1'
        expect(@guestdata).to be_valid
      end
      it 'thickness_idが0（未選択）以外であれば登録できる' do
        @guestdata.thickness_id = '1'
        expect(@guestdata).to be_valid
      end
      it 'remark_drinkが空でも登録できる' do
        @guestdata.remark_drink = ''
        expect(@guestdata).to be_valid
      end
    end

    context '一括新規登録がうまくいかないとき' do
      it 'first_nameが空だと登録できない' do
        @guestdata.first_name = ''
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("First name can't be blank", 'First name は全角で入力してください')
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @guestdata.first_name = 'a'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include('First name は全角で入力してください')
      end
      it 'last_nameが空では登録できない' do
        @guestdata.last_name = ''
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("Last name can't be blank", 'Last name は全角で入力してください')
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @guestdata.last_name = 'a'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include('Last name は全角で入力してください')
      end
      it 'First_name_kanaが空では登録できない' do
        @guestdata.first_name_kana = ''
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("First name kana can't be blank", 'First name kana はカタカナで入力してください')
      end
      it 'first_name_kanaが全角（カタカナ）以外では登録できない' do
        @guestdata.first_name_kana = 'a'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include('First name kana はカタカナで入力してください')
      end
      it 'last_name_kanaが空では登録できない' do
        @guestdata.last_name_kana = ''
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana はカタカナで入力してください')
      end
      it 'last_name_kanaが全角（カタカナ）以外では登録できない' do
        @guestdata.last_name_kana = 'a'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include('Last name kana はカタカナで入力してください')
      end
      it 'gender_idが0（未選択）では登録できない' do
        @guestdata.gender_id = '0'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("Gender の選択肢を選んでください")
      end
      it 'visit1_idが0（未選択）では登録できない' do
        @guestdata.visit1_id = '0'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("Visit1 の選択肢を選んでください")
      end
      it 'adl_idが0（未選択）では登録できない' do
        @guestdata.adl_id = '0'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("Adl の選択肢を選んでください")
      end
      it 'bathing_idが0（未選択）では登録できない' do
        @guestdata.bathing_id = '0'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("Bathing の選択肢を選んでください")
      end
      it 'infection_idが0（未選択）では登録できない' do
        @guestdata.infection_id = '0'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("Infection の選択肢を選んでください")
      end
      it 'drink_type_idが0（未選択）では登録できない' do
        @guestdata.drink_type_id = '0'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("Drink type の選択肢を選んでください")
      end
      it 'thickness_idが0（未選択）では登録できない' do
        @guestdata.thickness_id = '0'
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include("Thickness の選択肢を選んでください")
      end
      it 'warmが空では登録できない' do
        @guestdata.warm = nil
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include('Warm is not included in the list')
      end
      it 'diabetesが空では登録できない' do
        @guestdata.diabetes = nil
        @guestdata.valid?
        expect(@guestdata.errors.full_messages).to include('Diabetes is not included in the list')
      end
    end
  end
end