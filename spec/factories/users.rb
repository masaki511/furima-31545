FactoryBot.define do
  Faker::Config.locale = :ja
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { Faker::Alphanumeric.alphanumeric(number: 6) }
    password_confirmation { password }
    lastname { person.last.kanji }
    firstname { person.first.kanji }
    lastname_kana { person.last.katakana }
    firstname_kana { person.first.katakana }
    birthday { Faker::Time.between(from: '1930-01-01', to: '2016-12-31') }
  end
end
