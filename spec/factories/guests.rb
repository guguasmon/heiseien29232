FactoryBot.define do
  factory :guest do
    first_name             { Gimei.unique.last.kanji }
    last_name              { Gimei.unique.first.kanji }
    first_name_kana        { Gimei.unique.last.katakana }
    last_name_kana         { Gimei.unique.first.katakana }
    gender_id              { 1 }
    visit1_id              { 3 }
    visit2_id              { 4 }
    adl_id                 { 1 }
    description            { Faker::Lorem.sentence }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/muon-ash.jpg'), filename: 'muon-ash.jpg')
    end
  end
end
