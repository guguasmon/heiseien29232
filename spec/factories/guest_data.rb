FactoryBot.define do
  factory :guest_data do
    first_name             { Gimei.last.kanji }
    last_name              { Gimei.first.kanji }
    first_name_kana        { Gimei.last.katakana }
    last_name_kana         { Gimei.first.katakana }
    gender_id              { 1 }
    visit1_id              { 1 }
    visit2_id              { 2 }
    adl_id                 { 1 }
    description            { '' }
    bathing_id             { 1 }
    infection_id           { 1 }
    timing_id              { 1 }
    remark_bath            { '' }
    drink_type_id          { 1 }
    thickness_id           { 1 }
    warm                   { 'false' }
    diabetes               { 'false' }
    remark_drink           { '' }
  end
end
