FactoryBot.define do
  factory :comment do
    text { '新規登録しました' }
    comment_type_id { 1 }
    before { '変更前' }
    after { '変更後' }
    association :user
    association :guest
  end
end
