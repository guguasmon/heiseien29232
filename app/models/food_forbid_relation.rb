class FoodForbidRelation < ApplicationRecord
  belongs_to :food
  belongs_to :forbid
end
