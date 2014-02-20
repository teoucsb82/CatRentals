class User < ActiveRecord::Base
  attr_reader :password

  validates :password, :length => { :minimum => 3, :allow_nil => true }
  validates :user_name, :presence => true, :uniqueness => true
  validates :password_digest, :presence => true
  validates :session_token, :presence => true, :uniqueness => true

  before_validation :ensure_session_token


  def self.find_by_credentials(params)
    user = User.find_by_user_name(params[:user_name])
    return user if user && user.is_password?(params[:password]) #we found a valid user
    nil                                                         #we did not find a valid user
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def password=(plaintext)
    @password = plaintext
    self.password_digest = BCrypt::Password.create(plaintext)
  end

  def is_password?(plaintext)
    BCrypt::Password.new(self.password_digest).is_password?(plaintext)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end