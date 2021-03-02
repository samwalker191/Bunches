# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  username            :string           not null
#  ripeness_preference :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  password_digest     :string           not null
#  session_token       :string           not null
#
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :bunches_to_sell,
    foreign_key: :seller_id,
    class_name: :Bunche

  attr_reader :password
  after_initialize :ensure_session_token
  # before_validation :ensure_session_token

  # RIPES

  # R
  def reset_session_token!
    # set the user's session token to be a new random string thing
    # update the database with that new session_token
    # return the new session token

    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  # I
  def is_password?(password)
    # is to check whether or not a plain text password is 'equivalent' 
    # to the password_digest that we have stored

    # Password.new creates an Password object from a password_digest
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  # P
  def password=(password)
    # User.new
    # sets a @password instance variable
    # sets our password_digest
    @password = password
    # Password.create creates a Password object from a plain text password
    self.password_digest = BCrypt::Password.create(password)
  end

  # E
  def ensure_session_token
    # sets a session_token if there isnt one already
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  # S
  def self.find_by_credentials(username, password)
    # first, find the user by their username
    # if the user exists, check the password with the password_digest
    # if it matches, return the user
    # else, return nil

    user = User.find_by(username: username)

    if user && user.is_password?(password)
      user
    else
      nil
    end
  end
end
