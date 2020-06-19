FactoryBot.define do
  factory :instructor do
    email{"example@gmail.com"}
    password{"password"}
    confirmed_at{Date.today}

    trait :created do
      name{"ぼるきゃり"}
      age{"20代"}
      profile{"よろしくお願いします"}
      status{"社会人"}
      industry{"IT"}
      occupation{"エンジニア"}
    end
    
  end
end
