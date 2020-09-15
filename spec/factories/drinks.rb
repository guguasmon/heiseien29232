FactoryBot.define do
  factory :drink do
    drink_type_id      { 1 }
    thickness_id       { 1 }
    warm               { 'false' }
    diabetes           { 'false' }
    remark_drink       { '12345678901234567890' }
    association :guest
  end
end
