FactoryGirl.define do
  factory :team do
    name { Faker::Company.name }
    description { Faker::Company.catch_phrase }
  end
end
