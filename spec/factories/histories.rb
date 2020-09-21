FactoryBot.define do
  factory :history do
    log { '新規登録しました' }
    log_type_id       { 1 }
    association :guest
  end
end
