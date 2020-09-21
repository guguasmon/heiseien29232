class History < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :guest
  belongs_to_active_hash :log_type
end
