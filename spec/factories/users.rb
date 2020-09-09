FactoryBot.define do
  factory :user do
    name                  { Gimei.name }
    email                 { Faker::Internet.free_email }
    password              { 'abc123' }
    password_confirmation { password }
  end
end
