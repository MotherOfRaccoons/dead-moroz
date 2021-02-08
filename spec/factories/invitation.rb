FactoryBot.define do
  factory :invitation do
    email { Faker::Internet.unique.email }
    token { Faker::Alphanumeric.alphanumeric(number: 24) }
  end
end
