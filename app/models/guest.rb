class Guest < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :gender
  belongs_to_active_hash :visit1
  belongs_to_active_hash :visit2
  belongs_to_active_hash :adl

  has_one_attached :image
  belongs_to :user
  has_many   :comments, dependent: :destroy
  has_many   :histories, dependent: :destroy
  has_one    :bath, dependent: :destroy
  has_one    :drink, dependent: :destroy
  has_one    :food, dependent: :destroy

  # name,remarksというエイリアスをつける
  ransack_alias :name, :first_name_or_last_name_or_first_name_kana_or_last_name_kana
  ransack_alias :remarks, :description_or_bath_remark_bath_or_drink_remark_drink_or_food_remark_food

  validates :description, length: { maximum: 1000 }
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
end
