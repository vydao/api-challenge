require 'rails_helper'

RSpec.describe User, type: :model do
  context "#set_authentication_token!" do
    let(:user) { User.new(name: 'tester') }

    it "generates a unique token" do
      allow(SecureRandom).to receive(:uuid).and_return("auniquetoken")
      user.save
      expect(user.name).to eq "tester"
      expect(user.auth_token).to eq "auniquetoken"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      user.save
      expect(user.auth_token).not_to eq existing_user.auth_token
    end
  end
end
