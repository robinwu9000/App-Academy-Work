class User < ActiveRecord::Base
  validates :username, :presence => true
  validates :password, length: {minimum: 6, allow_nil: true}
  before_validation :ensure_session_token
  attr_reader :password

  has_many :cats

  has_many :sessions

  has_many :cat_rental_requests

  def reset_session_token!
    @session_token = generate_session_token
    if sessions.empty?
      Session.create!(session_token: @session_token, user_id: self.id)
    end
  end

  def generate_session_token
    SecureRandom::urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    @user = User.find_by(:username => user_name)
    if @user && @user.is_password?(password)
      return @user
    else
      nil
    end
  end

  def ensure_session_token
    @session_token = generate_session_token
    if sessions.empty?
      Session.create!(session_token: @session_token, user_id: self.id)
    end
  end

end
