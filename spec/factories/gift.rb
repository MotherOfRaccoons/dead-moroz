FactoryBot.define do
  factory :gift do
    title       { Faker::Book.title }
    description { Faker::Lorem.sentence(word_count: 10) }
    recipient   { association :user }
  end
end
