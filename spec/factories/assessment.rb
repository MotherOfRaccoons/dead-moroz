FactoryBot.define do
  factory :assessment do
    value   { Faker::Number.within(range: 1..10) }
    comment { Faker::Lorem.sentence(word_count: 10) }
    author  { association :user }
    target  { association :user }
  end
end
