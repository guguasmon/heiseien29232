class Bath < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :bathing
  belongs_to_active_hash :infecton
  belongs_to_active_hash :timing

  belongs_to :guest

  with_options presence: true do
    validates :bathing_id
    validates :infection_id
    validates :timing_id
    with_options numericality: { other_than: 0, message: "can't be blank" } do
      validates :bating_id
      validates :infection_id
    end
  end
end
