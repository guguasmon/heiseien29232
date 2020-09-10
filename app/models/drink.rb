class Drink < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :thickness

  belongs_to :guest
  belongs_to :drink_type
end
