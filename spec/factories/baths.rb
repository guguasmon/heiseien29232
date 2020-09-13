FactoryBot.define do
  factory :bath do
    bathing_id              { 1 }
    infection_id            { 1 }
    timing_id               { 2 }
    remark_bath             { "" }
    association :guest
  end
end
