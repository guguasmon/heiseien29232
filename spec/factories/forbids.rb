FactoryBot.define do
  factory :forbid do
    forbid_food   { Faker::Name.unique.first_name }
  end
end
