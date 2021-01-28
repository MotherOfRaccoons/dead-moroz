if Rails.env.development?
  namespace :dev do
    desc 'Sample data for local development environment'
    task populate: 'db:migrate:reset' do
      include FactoryBot::Syntax::Methods
      password = 'password'

      create(:user, :kid, :no_avatar, email: 'kid@mail.com', password: password) do |kid|
        create_list(:gift, 3, recipient: kid, added_by: kid)
      end
      create(:user, :kid, :no_avatar, email: 'kid1@mail.com', password: password) do |kid|
        create_list(:gift, 3, recipient: kid, added_by: kid)
      end
      create(:user, :elf,   :no_avatar, email: 'elf@mail.com',   password: password)
      create(:user, :elf,   :no_avatar, email: 'elf2@mail.com',  password: password)
      create(:user, :santa, :no_avatar, email: 'santa@mail.com', password: password)
      create(:user, :admin, :no_avatar, email: 'admin@mail.com', password: password)
    end
  end
end
