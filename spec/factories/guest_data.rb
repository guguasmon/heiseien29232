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
    description            { '12345678901234567890' }
    bathing_id             { 1 }
    infection_id           { 1 }
    timing_id              { 3 }
    remark_bath            { '12345678901234567890' }
    drink_type_id          { 1 }
    thickness_id           { 1 }
    warm                   { 'false' }
    diabetes               { 'false' }
    remark_drink           { '12345678901234567890' }
    staple_type_id         { 1 }
    staple_amount_id       { 1 }
    main_dish_type_id      { 1 }
    main_dish_amount_id    { 1 }
    side_dish_type_id      { 1 }
    side_dish_amount_id    { 1 }
    forbid_food            { Faker::Food.unique.fruits }
    low_salt               { 'false' }
    soup_thick             { 'false' }
    denture_id             { 1 }
    remark_food            { '12345678901234567890' }
    log                    { '新規登録しました' }
    log_type_id            { 0 }
  end
end
