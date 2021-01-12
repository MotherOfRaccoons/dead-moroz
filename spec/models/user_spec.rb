require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  describe '#first_name' do
    specify do
      expect(user).to validate_presence_of(:first_name)
    end

    specify do
      expect(user).to validate_length_of(:first_name).is_at_most(25)
    end
  end

  describe '#last_name' do
    specify do
      expect(user).to validate_presence_of(:last_name)
    end

    specify do
      expect(user).to validate_length_of(:last_name).is_at_most(25)
    end
  end

  describe '#middle_name' do
    specify do
      expect(user).to validate_length_of(:middle_name).is_at_most(25)
    end
  end

  describe '#address' do
    specify do
      expect(user).to validate_presence_of(:address)
    end

    specify do
      expect(user).to validate_length_of(:address).is_at_most(50)
    end
  end

  describe '#gender' do
    specify do
      expect(user).to validate_presence_of(:gender)
    end

    specify do
      expect(user).to define_enum_for(:gender).with_values(%i[male female non_binary])
    end
  end

  describe '#behavior' do
    specify do
      expect(user).to validate_presence_of(:behavior)
    end

    specify do
      expect(user).to validate_length_of(:behavior)
        .is_at_least(10).is_at_most(280)
    end
  end
end
