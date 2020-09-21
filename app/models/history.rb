class History < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :guest
  belongs_to_active_hash :log_type

  with_options presence: true do
    validates :log
    validates :log_type_id
  end
end
