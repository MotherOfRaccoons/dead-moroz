FactoryBot.define do
  factory :image do
    image { Rack::Test::UploadedFile.new(Rails.root.join('public/placeholder.jpg'), 'image/jpeg') }
    gift  { association :gift }
  end
end
