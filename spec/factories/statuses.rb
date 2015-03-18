FactoryGirl.define do
  factory :status do
    user

    description { Faker::Lorem.sentence }
  end
end
