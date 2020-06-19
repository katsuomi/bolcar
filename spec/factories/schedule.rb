FactoryBot.define do
  factory :schedule do
    association :instructor, :created
    date{Date.tomorrow}
    start_time{Time.current}
  end
end
