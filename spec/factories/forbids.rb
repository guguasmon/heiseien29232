FactoryBot.define do
  factory :forbid do
    forbid_food   { Faker::Food.unique.fruits }
  end
end
