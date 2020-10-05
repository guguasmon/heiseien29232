class Forbid < ApplicationRecord
  has_many :food_forbid_relations
  has_many :foods, through: :food_forbid_relations
end
