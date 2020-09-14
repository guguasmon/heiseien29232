FactoryBot.define do
  factory :guest do
    first_name             { Gimei.last.kanji }
    last_name              { Gimei.first.kanji }
    first_name_kana        { Gimei.last.katakana }
    last_name_kana         { Gimei.first.katakana }
    gender_id              { 1 }
    visit1_id              { 1 }
    visit2_id              { 2 }
    adl_id                 { 1 }
    description            { Faker::Lorem.sentence }
    association :user
  end
end
