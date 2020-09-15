class Drink < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :thickness
  belongs_to_active_hash :drink_type

  belongs_to :guest

  # # boolean型のチェック
  validates :warm, inclusion: { in: [true, false] }
  validates :diabetes, inclusion: { in: [true, false] }
  validates :remark_drink, length: { maximum: 20 }

  with_options presence: true do
    validates :drink_type_id
    validates :thickness_id
    with_options numericality: { other_than: 0, message: 'の選択肢を選んでください' } do
      validates :drink_type_id
      validates :thickness_id
    end
  end
end
