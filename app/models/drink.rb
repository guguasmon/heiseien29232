class Drink < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :thickness
  belongs_to_active_hash :drink_type

  belongs_to :guest
end
