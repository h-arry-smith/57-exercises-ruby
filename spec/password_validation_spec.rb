require 'bcrypt'
require_relative '../password_validation'

# Speed up tests using bcrypt by setting cost to low
BCrypt::Engine::DEFAULT_COST = 1

RSpec.describe PasswordManager do
  describe 'registering users' do
    it 'can register a user to the manager with usename and password' do
      manager = PasswordManager.new

      manager.register_user('test-user', 'test-password')

      expect(manager.users.length).to eq(1)
    end

    it 'does not register a user if username or password is blank' do
      manager = PasswordManager.new

      expect { manager.register_user('', 'test-password') }.to raise_exception(ArgumentError)
      expect { manager.register_user('test-user', '') }.to raise_exception(ArgumentError)
      expect(manager.users.length).to eq(0)
    end

    it 'does not allow the same username to be registered more than once' do
      manager = PasswordManager.new
      manager.register_user('test-user', 'test-password')

      expect { manager.register_user('test-user', 'different-password') }.to raise_exception(UserAlreadyExistsError)
    end

    it 'stores the password in encrypted form' do
      manager = PasswordManager.new
      new_user = manager.register_user('test-user', 'test-password')

      expect(BCrypt::Password.new(new_user[:password])).to eq('test-password')
    end
  end

  describe 'finding users' do
    it 'can return the user by user name' do
      manager = PasswordManager.new
      manager.register_user('test-user', 'test-password')

      expect(manager.find_user('test-user')[:user]).to eq('test-user')
    end

    it 'can tell you if a user already exists or not' do
      manager = PasswordManager.new
      manager.register_user('test-user', 'test-password')

      expect(manager.user_exists?('test-user')).to be true
      expect(manager.user_exists?('doesnt-exist')).to be false
    end
  end

  describe 'logging in a user' do
    it 'returns true if the user name and password is correct' do
      manager = PasswordManager.new
      manager.register_user('test-user', 'test-password')

      expect(manager.login('test-user', 'test-password')).to be true
    end

    it 'returns false if user name and password is incorrect' do
      manager = PasswordManager.new
      manager.register_user('test-user', 'test-password')

      expect(manager.login('test-user', 'wrong-password')).to be false
      expect(manager.login('wrong-user', 'test-password')).to be false
    end
  end
end
