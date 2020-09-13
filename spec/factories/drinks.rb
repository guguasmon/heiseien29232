FactoryBot.define do
  factory :drink do
    drink_type_id      { 1 }
    thickness_id       { 1 }
    warm               { "false" }
    diabetes           { "false" }
    remark_drink       { "" }
    association :guest
  end
end
