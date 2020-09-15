class Bath < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :bathing
  belongs_to_active_hash :infection
  belongs_to_active_hash :timing

  belongs_to :guest

  validates :remark_bath, length: { maximum: 20 }
  with_options presence: true do
    validates :bathing_id
    validates :infection_id
    validates :timing_id
    with_options numericality: { other_than: 0, message: 'の選択肢を選んでください' } do
      validates :bathing_id
      validates :infection_id
    end
  end
end
