require 'bcrypt'

class PasswordManager
  attr_reader :users

  def initialize
    @users = []
  end

  def register_user(user, password)
    raise ArgumentError if (user.empty? || password.empty?)
    raise UserAlreadyExistsError if user_exists?(user)

    new_user = { user: user, password: BCrypt::Password.create(password) }

    @users << new_user
    new_user
  end

  def find_user(username)
    @users.find { |user| user[:user] == username }
  end

  def user_exists?(username)
    @users.any? { |user| user[:user] == username }
  end

  def login(username, password)
    user = find_user(username)

    !user.nil? && user[:password] == password
  end
end

class UserAlreadyExistsError < StandardError
end
