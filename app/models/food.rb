class Food < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :staple_type
  belongs_to_active_hash :staple_amount
  belongs_to_active_hash :main_dish_type
  belongs_to_active_hash :main_dish_amount
  belongs_to_active_hash :side_dish_type
  belongs_to_active_hash :side_dish_amount
  belongs_to_active_hash :denture

  belongs_to :guest
  has_many :food_forbid_relations
  has_many :forbids, through: :food_forbid_relations
  
  # boolean型のチェック
  validates :low_salt,   inclusion: { in: [true, false] }
  validates :soup_thick, inclusion: { in: [true, false] }
  # 文字数のチェック
  validates :remark_food, length: { maximum: 20 }

  with_options presence: true do
    validates :staple_type_id
    validates :staple_amount_id
    validates :main_dish_type_id
    validates :main_dish_amount_id
    validates :side_dish_type_id
    validates :side_dish_amount_id
    validates :denture_id
    with_options numericality: { other_than: 0, message: 'の選択肢を選んでください' } do
      validates :staple_type_id
      validates :main_dish_type_id
      validates :side_dish_type_id
      validates :denture_id
    end
  end
end
