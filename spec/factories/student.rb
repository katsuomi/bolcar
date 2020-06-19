FactoryBot.define do
  factory :student do
    email{"example@gmail.com"}
    password{"password"}
    confirmed_at{Date.today}

    trait :created do
      name{"ぼるきゃり"}
      profile{"よろしくお願いします"}
      graduation_year{"2021年"}
    end

  end
end
