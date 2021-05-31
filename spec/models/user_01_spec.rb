# frozen_string_literal: true

RSpec.describe User, type: :model do
  it { expect(described_class).to respond_to(:new) }

  describe 'instance' do
    it { expect(described_class.new).to respond_to(:email) }
    it { expect(described_class.new).to respond_to(:password) }
  end

  describe 'clearance' do
    let(:password) { Faker::Lorem.sentence }
    let(:user) { Fabricate(:user, password: password) }

    it 'authenticate user' do
      expect(described_class).to respond_to(:authenticate)
      expect(described_class.authenticate(user.email, password)).to eq(user)
    end

    it "doesn't authenticate user if password is wrong" do
      expect(described_class.authenticate(user.email, password.reverse)).to be nil
    end
  end
end
