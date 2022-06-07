require 'clipboard'
require_relative '../password_generator'

SPECIAL = ['!', '@', '£', '#', '%', '^', '&', '*', '\\',]

RSpec.describe PasswordGenerator do
  describe '#random_letter' do
    it 'returns a random letter' do
      expect(PasswordGenerator.random_letter).to(satisfy { |v| v.match? /[a-zA-Z]/ })
    end
  end

  describe '#random_letters' do
    it 'returns an array of random letters' do
      expect(PasswordGenerator.random_letters(8).length).to eq(8)
      expect(PasswordGenerator.random_letters(8).join).to(satisfy { |v| v.match? /[a-zA-Z]/ })
    end
  end

  describe '#random_number' do
    it 'returns a random number' do
      expect(PasswordGenerator.random_number).to be_between(0, 9)
    end
  end

  describe '#random_numbers' do
    it 'returns an array of random numbers of length n' do
      arr = PasswordGenerator.random_numbers(8)

      expect(arr.length).to eq(8)
      expect(arr).to satisfy do |v|
        v.all? { |x| x >= 0 && x <= 9 }
      end
    end
  end

  describe '#random_special_char' do
    it 'returns a special character' do
      expect(PasswordGenerator.random_special_char).to satisfy { |v| SPECIAL.include? v}
    end
  end

  describe '#random_special_chars' do
    it 'returns an array of random special chars of length n' do
      arr = PasswordGenerator.random_special_chars(8)

      expect(arr.length).to eq(8)
      expect(arr).to satisfy do |v|
        v.all? { |x| SPECIAL.include? x }
      end
    end
  end

  describe '#random_password' do
    it 'returns a string of the correct length' do
      password = PasswordGenerator.random_password(8, 0, 0)

      expect(password.length).to eq(8)
    end

    it 'returns a string with the correct number of letters, numbers and special chars' do
      password = PasswordGenerator.random_password(8, 4, 6).split('')

      letters = password.count { |c| c.match?(/[a-zA-Z]/) }
      numbers = password.count { |c| c.match?(/\d/) }
      special = password.count { |c| SPECIAL.include? c }

      expect(letters).to eq(8)
      expect(numbers).to eq(4)
      expect(special).to eq(6)
    end
  end

  describe '#random_passwords' do
    it 'returns an array of random passwords config options' do
      passwords = PasswordGenerator.random_passwords(10, {letters: 8, numbers: 4, special: 4})

      expect(passwords.length).to eq(10)
    end
  end

  describe '#password_to_clipboard' do
    it 'copies a password to the clipboard' do
      password = PasswordGenerator.password_to_clipboard(8, 2, 2)

      expect(Clipboard.paste).to eq(password)
    end
  end
end
