class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token

  has_many :goals
  has_many :user_comments 

  attr_reader :password

  def self.find_by_credentials(username, password)
     user = User.find_by(username: username)
    if user && user.is_password?(password)
      return user
    else
       nil
     end
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    save!
    session_token
  end

  def is_password?(password)
    bc = BCrypt::Password.new(self.password_digest)
    bc.is_password?(password)
  end

  def completed_goals
    Goal.where(user_id: self.id, completed: true)
  end
end
