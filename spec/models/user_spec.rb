require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User do
  include CarrierWave::Test::Matchers

  describe 'Attributes' do
    let(:user) { build_stubbed(:user) }
    let(:uploader) { AvatarUploader.new(user, :avatar) }

    it 'when valid the user is valid' do
      expect(user).to be_valid
    end

    describe '#avatar' do
      before do
        AvatarUploader.enable_processing = true
      end

      after do
        AvatarUploader.enable_processing = false
        uploader.remove!
      end

      context 'with the normal version' do
        it 'scales down an image to be exactly 200 by 200 pixels' do
          expect(user.avatar).to have_dimensions(200, 200)
        end
      end

      context 'with the thumb version' do
        it 'scales down ane image to be exactly 50 by 50 pixels' do
          expect(user.avatar.thumb).to have_dimensions(50, 50)
        end
      end

      context 'when absent' do
        it 'shows default image' do
          user.avatar = nil
          expect(user.avatar.url).to include('avatars.dicebear.com')
        end
      end
    end

    describe '#email' do
      specify { expect(build(:user)).to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end

    describe '#first_name' do
      specify { expect(user).to validate_presence_of(:first_name) }
      specify { expect(user).to validate_length_of(:first_name).is_at_most(25) }
    end

    describe '#last_name' do
      specify { expect(user).to validate_presence_of(:last_name) }
      specify { expect(user).to validate_length_of(:last_name).is_at_most(25) }
    end

    describe '#middle_name' do
      specify { expect(user).to validate_length_of(:middle_name).is_at_most(25) }
    end

    describe '#address' do
      specify { expect(user).to validate_presence_of(:address) }
      specify { expect(user).to validate_length_of(:address).is_at_most(100) }
    end

    describe '#gender' do
      specify { expect(user).to validate_presence_of(:gender) }
      specify { expect(user).to define_enum_for(:gender).with_values(%i[male female non_binary]) }
    end

    describe '#behavior' do
      specify { expect(user).to validate_length_of(:behavior).is_at_most(280) }
    end

    describe '#role' do
      specify { expect(user).to validate_presence_of(:role) }
      specify { expect(user).to define_enum_for(:role).with_values(%i[kid elf santa admin]) }
    end
  end

  describe 'Abilities' do
    subject(:ability) { Ability.new(user) }

    let(:kid)   { build_stubbed(:user, :kid) }
    let(:elf)   { build_stubbed(:user, :elf) }
    let(:gift)  { build_stubbed(:gift, added_by: user, recipient: kid) }
    let(:image) { build_stubbed(:image, gift: gift) }
    let(:assessment) { build_stubbed(:assessment, author: user, target: kid) }
    let(:review)     { build_stubbed(:review, reviewer: user, reviewee: kid) }

    context 'when is a kid' do
      let(:user) { kid }

      specify { expect(ability).to be_able_to(%i[index show create update destroy], gift) }
      specify { expect(ability).to be_able_to(:show, user) }
      specify { expect(ability).to be_able_to(:manage, image) }
    end

    context 'when is an elf' do
      let(:user) { elf }

      specify { expect(ability).to be_able_to(:read, described_class) }
      specify { expect(ability).to be_able_to(%i[read create update destroy], gift) }
      specify { expect(ability).to be_able_to(:manage, image) }
      specify { expect(ability).to be_able_to(%i[show create destroy], assessment) }
      specify { expect(ability).to be_able_to(%i[show create destroy], review) }
    end

    context 'when is the Santa' do
      let(:user) { build_stubbed(:user, :santa) }

      specify { expect(ability).to be_able_to(:read, described_class) }
      specify { expect(ability).to be_able_to(%i[read toggle_selected create update destroy], gift) }
      specify { expect(ability).to be_able_to(%i[read create destroy], assessment) }
      specify { expect(ability).to be_able_to(:create, review) }
      specify { expect(ability).to be_able_to(%i[show destroy], Review) }
      specify { expect(ability).to be_able_to(:manage, Invitation) }
    end
  end
end
