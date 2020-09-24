require 'rails_helper'

RSpec.describe Guest, type: :model do
  before do
    @guest = FactoryBot.build(:guest)
  end
  describe '利用者新規登録' do
    context '新規登録がうまくいくとき' do
      it 'first_name,last_name,first_name_kana,last_name_kana,gender_id,visit1_id,visit2_id,adl_idが存在すれば登録できる' do
        expect(@guest).to be_valid
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @guest.first_name = '漢字ひらがなカタカナ'
        expect(@guest).to be_valid
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @guest.last_name = '漢字ひらがなカタカナ'
        expect(@guest).to be_valid
      end
      it 'first_name_kanaが全角（カタカナ）であれば登録できる' do
        @guest.first_name_kana = 'カタカナ'
        expect(@guest).to be_valid
      end
      it 'last_name_kanaが全角（カタカナ）であれば登録できる' do
        @guest.last_name_kana = 'カタカナ'
        expect(@guest).to be_valid
      end
      it 'gender_idが１か２であれば登録できる' do
        @guest.gender_id = '1'
        expect(@guest).to be_valid
      end
      it 'gender_idが１か２であれば登録できる' do
        @guest.gender_id = '2'
        expect(@guest).to be_valid
      end
      it 'visit1_idがあれば登録できる' do
        @guest.visit1_id = '1'
        expect(@guest).to be_valid
      end
      it 'visit2_idがあれば登録できる' do
        @guest.visit2_id = '1'
        expect(@guest).to be_valid
      end
      it 'visit2_idが0(未選択)でも登録できる' do
        @guest.visit2_id = '0'
        expect(@guest).to be_valid
      end
      it 'adl_idがあれば登録できる' do
        @guest.adl_id = '1'
        expect(@guest).to be_valid
      end
      it 'descriptionが空でも登録できる' do
        @guest.description = ''
        expect(@guest).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'first_nameが空だと登録できない' do
        @guest.first_name = ''
        @guest.valid?
        expect(@guest.errors.full_messages).to include("First name can't be blank", 'First name full-width characters.')
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @guest.first_name = 'a'
        @guest.valid?
        expect(@guest.errors.full_messages).to include('First name full-width characters.')
      end
      it 'last_nameが空では登録できない' do
        @guest.last_name = ''
        @guest.valid?
        expect(@guest.errors.full_messages).to include("Last name can't be blank", 'Last name full-width characters.')
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @guest.last_name = 'a'
        @guest.valid?
        expect(@guest.errors.full_messages).to include('Last name full-width characters.')
      end
      it 'First_name_kanaが空では登録できない' do
        @guest.first_name_kana = ''
        @guest.valid?
        expect(@guest.errors.full_messages).to include("First name kana can't be blank", 'First name kana full-width katakana characters.')
      end
      it 'first_name_kanaが全角（カタカナ）以外では登録できない' do
        @guest.first_name_kana = 'a'
        @guest.valid?
        expect(@guest.errors.full_messages).to include('First name kana full-width katakana characters.')
      end
      it 'last_name_kanaが空では登録できない' do
        @guest.last_name_kana = ''
        @guest.valid?
        expect(@guest.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana full-width katakana characters.')
      end
      it 'last_name_kanaが全角（カタカナ）以外では登録できない' do
        @guest.last_name_kana = 'a'
        @guest.valid?
        expect(@guest.errors.full_messages).to include('Last name kana full-width katakana characters.')
      end
      it 'gender_idが空では登録できない' do
        @guest.gender_id = ''
        @guest.valid?
        expect(@guest.errors.full_messages).to include("Gender can't be blank")
      end
      it 'gender_idが0（未選択）では登録できない' do
        @guest.gender_id = '0'
        @guest.valid?
        expect(@guest.errors.full_messages).to include("Gender can't be blank")
      end
      it 'visit1_idが空では登録できない' do
        @guest.visit1_id = ''
        @guest.valid?
        expect(@guest.errors.full_messages).to include("Visit1 can't be blank")
      end
      it 'visit1_idが0（未選択）では登録できない' do
        @guest.visit1_id = '0'
        @guest.valid?
        expect(@guest.errors.full_messages).to include("Visit1 can't be blank")
      end
      it 'visit2_idが空では登録できない' do
        @guest.visit2_id = ''
        @guest.valid?
        expect(@guest.errors.full_messages).to include("Visit2 can't be blank")
      end
      it 'adl_idが空では登録できない' do
        @guest.adl_id = ''
        @guest.valid?
        expect(@guest.errors.full_messages).to include("Adl can't be blank")
      end
      it 'adl_idが0（未選択）では登録できない' do
        @guest.adl_id = '0'
        @guest.valid?
        expect(@guest.errors.full_messages).to include("Adl can't be blank")
      end
      it 'descriptionが1000文字以上では登録できない' do
        @guest.description = '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890'
        @guest.valid?
        expect(@guest.errors.full_messages).to include('Description is too long (maximum is 1000 characters)')
      end
    end
  end
end
