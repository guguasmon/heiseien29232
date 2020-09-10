class Bath < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :bathing
  belongs_to_active_hash :infecton
  belongs_to_active_hash :timing
  belongs_to :guest
end
