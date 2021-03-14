FactoryBot.define do
  Faker::Config.locale = :ja
  factory :item do
    name { Faker::String.random(length: 1..40) }
    explanation { Faker::String.random(length: 1..1000) }
    category_id { Faker::Number.within(range: 2..11) }
    condition_id { Faker::Number.within(range: 2..7) }
    delivery_fee_id { Faker::Number.within(range: 2..3) }
    area_id { Faker::Number.within(range: 2..48) }
    necessary_day_id { Faker::Number.within(range: 2..4) }
    price { Faker::Number.within(range: 300..9_999_999) }

    association :user
  end
end
