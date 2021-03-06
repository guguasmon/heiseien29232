FactoryBot.define do
  factory :food do
    staple_type_id      { 1 }
    staple_amount_id    { 1 }
    main_dish_type_id   { 1 }
    main_dish_amount_id { 1 }
    side_dish_type_id   { 1 }
    side_dish_amount_id { 1 }
    low_salt            { 'false' }
    soup_thick          { 'false' }
    denture_id          { 1 }
    remark_food         { '12345678901234567890' }
    association :guest
    after(:create) do |food|
      create_list(:forbid, 1, foods: [food])
    end
  end
end
