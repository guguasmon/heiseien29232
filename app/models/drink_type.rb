class DrinkType < ApplicationRecord
  has_many :drinks
  
  validates :name, presence: true
end
