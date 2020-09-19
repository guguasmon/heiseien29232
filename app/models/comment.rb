class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :guest
  belongs_to_active_hash :comment_type

  with_options presence: true do
    validates :text
    validates :comment_type_id
  end
end
