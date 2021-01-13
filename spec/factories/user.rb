FactoryBot.define do
  factory :user do
    email { 'mail@mail.com' }
    first_name { 'Boris' }
    last_name { 'Johnson' }
    birthdate { '1999-01-01' }
    gender { 'female' }
    address { 'Addr' }
    behavior { "I've been a good boy" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
