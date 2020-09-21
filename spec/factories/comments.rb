FactoryBot.define do
  factory :comment do
    text { 'コメントしました' }
    association :user
    association :guest
  end
end
