FactoryBot.define do
  factory :invitation do
    email { Faker::Internet.unique.email }
  end
end
