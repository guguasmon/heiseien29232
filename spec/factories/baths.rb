FactoryBot.define do
  factory :bath do
    bathing_id              { 1 }
    infection_id            { 1 }
    timing_id               { 3 }
    remark_bath             { Faker::Lorem.sentence }
    association :guest
  end
end
