FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.unique.email }
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    birthdate             { Faker::Date.between(from: 100.years.ago, to: Time.zone.today) }
    gender                { Faker::Gender.binary_type.downcase }
    address               { Faker::Address.full_address }
    behavior              { Faker::Lorem.sentence(word_count: 10) }
    password              { Faker::Internet.password(min_length: 6, max_length: 50) }
    password_confirmation { password }
    avatar                { Rack::Test::UploadedFile.new(Rails.root.join('public/placeholder.jpg'), 'image/jpeg') }
    role                  { association :role }

    trait :kid do
      role { association :role, name: 'kid' }
    end

    trait :elf do
      role { association :role, name: 'elf' }
    end

    trait :santa do
      role { association :role, name: 'santa' }
    end
  end
end
