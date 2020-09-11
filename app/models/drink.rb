class Drink < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :thickness
  belongs_to_active_hash :drink_type

  belongs_to :guest
  with_options presence: true do
    validates :drink_type_id
    validates :thickness_id
    validates :warm
    validates :diabetes
    with_options numericality: { other_than: 0, message: "can't be blank" } do
      validates :drink_type_id
      validates :thickness_id
    end
  end
end
