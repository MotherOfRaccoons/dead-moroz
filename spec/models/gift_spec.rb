require 'rails_helper'

RSpec.describe Gift, type: :model do
  let(:user) { build_stubbed(:user) }
  let(:gift) { build_stubbed(:gift, recipient: user) }

  it 'is valid with valid attributes' do
    expect(gift).to be_valid
  end

  describe '#title' do
    specify { expect(gift).to validate_presence_of(:title) }
    specify { expect(gift).to validate_length_of(:title).is_at_most(50) }
  end

  describe '#description' do
    specify { expect(gift).to validate_length_of(:description).is_at_most(100) }
  end
end
