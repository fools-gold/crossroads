FactoryGirl.define do
  factory :user do
    team

    # faker is bad at generating emails in other-than-western locales
    Faker::Config.locale = :en

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    timezone "UTC"
    admin false

    trait :admin do
      admin true
    end

    factory :user_with_statuses do
      transient do
        statuses_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:status, evaluator.statuses_count, user: user)
      end
    end

    factory :user_with_favorite do
      transient do
        status { create(:status) }
      end

      after(:create) do |user, evaluator|
        user.favorites << evaluator.status
      end
    end
  end
end
