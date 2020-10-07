class Forbid < ApplicationRecord
  has_many :food_forbid_relations, dependent: :destroy
  has_many :foods, through: :food_forbid_relations

  validates :forbid_food, uniqueness: { case_sensitive: true }
  validates :forbid_food, presence: true
end
