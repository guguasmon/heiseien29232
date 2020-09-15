FactoryBot.define do
  factory :bath do
    bathing_id              { 1 }
    infection_id            { 1 }
    timing_id               { 3 }
    remark_bath             { '12345678901234567890' }
    association :guest
  end
end
