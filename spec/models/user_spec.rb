require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6).on(:create) }


  describe "#is_password?" do
    it "returns true if password is correct password" do
      expect(user.is_password?("password1234")).to be true
    end
    it "returns false if incorrect password" do
      expect(user.is_password?("pefaoiejf")).to be false
    end
  end

  describe "#reset_session_token!" do

    it "returns a different session token value when called" do
      user.session_token = "session123"
      user.reset_session_token!
      expect(user.session_token).to_not eq("session123")
    end
    it "returns a session token as a result" do
      expect(user.reset_session_token!).to be_a(String)
    end

  end

  describe "::find_by_credentials" do
    it "should return nil if incorrect password or username" do
      create(:user)
      expect(User.find_by_credentials("Blooby", "123456")).to be_nil
      expect(User.find_by_credentials("Blob", "password1234")).to be_nil
    end
    it "should return user with correct username and password" do
      user1 = create(:user)
      expect(User.find_by_credentials("Blooby", "password1234")).to eq(user1)
    end
  end

end
