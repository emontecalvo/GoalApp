class User < ActiveRecord::Base
  after_initialize :ensure_session_token
  validates :username, :password_digest, :session_token, presence:true
  validates :password, length: {minimum: 6, allow_nil:true}
  has_many :goals
  attr_reader :password
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    self.save
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  private
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end


end
