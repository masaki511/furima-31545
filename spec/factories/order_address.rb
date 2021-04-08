FactoryBot.define do
  Faker::Config.locale = :ja
  factory :order_address do
    transient do
      address { Gimei.address }
    end

    postal_code { (Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s).to_s }
    area_id { Faker::Number.within(range: 2..48) }
    city { address.city.to_s }
    address_line do
      (address.town.to_s + Faker::Number.between(from: 1,
                                                 to: 1000).to_s + '-' + Faker::Number.between(from: 1,
                                                                                              to: 100).to_s + '-' + Faker::Number.between(
                                                                                                from: 1, to: 10
                                                                                              ).to_s).to_s
    end
    building_name { (Faker::Lorem.word + Faker::Number.between(from: 1, to: 5000).to_s).to_s }
    phone_number { Faker::Number.number(digits: 11).to_s }
    token { ('tok_' + Faker::Lorem.characters(number: 11, min_alpha: 11) + Faker::Number.number(digits: 17).to_s).to_s }
  end
end
