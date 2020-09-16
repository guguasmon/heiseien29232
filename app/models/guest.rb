class Guest < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :gender
  belongs_to_active_hash :visit1
  belongs_to_active_hash :visit2
  belongs_to_active_hash :adl

  belongs_to :user
  has_one    :bath, dependent: :destroy
  has_one    :drink, dependent: :destroy

  with_options presence: true do
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'full-width characters.' }
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'full-width characters.' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'full-width katakana characters.' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'full-width katakana characters.' }
    validates :gender_id
    validates :visit1_id
    validates :visit2_id
    validates :adl_id
    with_options numericality: { other_than: 0, message: "can't be blank" } do
      validates :gender_id
      validates :visit1_id
      validates :adl_id
    end
  end
  # 入浴形態表
  def self.bath_search(user, gender, bathing)
    Guest.joins(:user, :bath).where(users: { id: user }).where(gender_id: gender).where(baths: { bathing_id: bathing }).order('timing_id  ASC')
  end

  # 水分提供表
  def self.drink_search(user, drink_type)
    Guest.joins(:user, :drink).where(users: { id: user}).where(drinks: {drink_type_id: drink_type}).order('first_name_kana  ASC')
  end
end
