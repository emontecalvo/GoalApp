require 'rails_helper'

RSpec.describe User, type: :model do
  context "Validations" do
  # pending "add some examples to (or delete) #{__FILE__}"
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:password).is_at_least(6).on(:create)}
  end
  context "methods" do
    it 'finds a user by credentials' do
      user = User.new
      user.username = 'user1'
      user.password = 'password'
      user.save
      expect(User.find_by_credentials('user1', 'password')).to be_truthy
    end
    it 'finds a session token after initialize' do
      user2 = User.new
      expect(user2.session_token).not_to be_nil
    end
    it 'resets the session token' do
      user3 = User.new
      test_session_token = user3.session_token
      user3.reset_session_token
      expect(user3.session_token).not_to eq(test_session_token)
    end
    it 'sets the password ' do
      user4 = User.new(username: "user4")
      user4.password = "password"
      expect(user4.is_password?("password")).to be true
    end
    it 'does not save password in database' do
      user4 = User.new(username: "user4")
      user4.password = "password"
      user4.save
      expect(User.find_by_password_digest("password")).to be_nil
    end
  end
end
