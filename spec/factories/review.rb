FactoryBot.define do
  factory :review do
    body     { Faker::Lorem.sentence(word_count: 10) }
    reviewer { association :user }
    reviewee { association :user }
  end
end
