require 'rails_helper'

RSpec.describe Forbid, type: :model do
  before do
    @forbid = FactoryBot.build(:forbid)
  end
  describe '禁止食材の新規登録' do
    context '禁止食材の新規登録がうまくいくとき' do
      it 'forbid_foodが存在すれば登録できる' do
        expect(@forbid).to be_valid
      end
    end
    context '禁止食材の新規登録がうまくいかないとき' do
      it 'forbid_foodが空では登録できない' do
        @forbid.forbid_food = ''
        @forbid.valid?
        expect(@forbid.errors.full_messages).to include("Forbid food can't be blank")
      end
      it '重複したforbid_foodは登録できない' do
        @forbid.save
        another_forbid = FactoryBot.build(:forbid, forbid_food: @forbid.forbid_food)
        another_forbid.valid?
        expect(another_forbid.errors.full_messages).to include("Forbid food has already been taken")
      end
    end
  end
end
