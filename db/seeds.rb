require 'faker'

Role.create([
  { name: 'kid',   description: 'Manages a profile and adds gifts to the wishlist' },
  { name: 'elf',   description: 'Fact-checks kid profiles, assesses them and makes reviews' },
  { name: 'santa', description: 'Moderates elf reviews and selects final gifts for kids' },
  { name: 'admin', description: 'All permissions' }
])

User.create([
  {
    first_name: 'Kid',
    last_name:  Faker::Name.last_name,
    birthdate:  Faker::Date.between(from: 100.years.ago, to: Time.zone.today),
    gender:     'non_binary',
    address:    Faker::Address.full_address,
    behavior:   Faker::Lorem.sentence(word_count: 10),
    email:      'kid@mail.com',
    password:   'password',
    role:       Role.find_by(name: 'kid')
  },
  {
    first_name: 'Elf',
    last_name:  Faker::Name.last_name,
    birthdate:  Faker::Date.between(from: 100.years.ago, to: Time.zone.today),
    gender:     'non_binary',
    address:    Faker::Address.full_address,
    behavior:   Faker::Lorem.sentence(word_count: 10),
    email:      'elf@mail.com',
    password:   'password',
    role:       Role.find_by(name: 'elf')
  },
  {
    first_name: 'Santa',
    last_name:  Faker::Name.last_name,
    birthdate:  Faker::Date.between(from: 100.years.ago, to: Time.zone.today),
    gender:     'non_binary',
    address:    Faker::Address.full_address,
    behavior:   Faker::Lorem.sentence(word_count: 10),
    email:      'santa@mail.com',
    password:   'password',
    role:       Role.find_by(name: 'santa')
  },
  {
    first_name: 'Admin',
    last_name:  Faker::Name.last_name,
    birthdate:  Faker::Date.between(from: 100.years.ago, to: Time.zone.today),
    gender:     'non_binary',
    address:    Faker::Address.full_address,
    behavior:   Faker::Lorem.sentence(word_count: 10),
    email:      'admin@mail.com',
    password:   'password',
    role:       Role.find_by(name: 'amin')
  }
])
