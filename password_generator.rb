require 'clipboard'

class PasswordGenerator
  ALPHA = ('a'..'z').to_a.concat ('A'..'Z').to_a
  SPECIAL = ['!', '@', '£', '#', '%', '^', '&', '*', '\\']

  def self.random_letter
    ALPHA[rand(0...ALPHA.length)]
  end

  def self.random_letters(n)
    (1..n).map { random_letter }
  end

  def self.random_number
    rand(0..9)
  end

  def self.random_numbers(n)
    (1..n).map { random_number }
  end

  def self.random_special_char
    SPECIAL[rand(0...SPECIAL.length)]
  end

  def self.random_special_chars(n)
    (1..n).map { random_special_char }
  end

  def self.random_password(number_of_letters, number_of_numbers, number_of_special)
    chars = random_letters(number_of_letters) + random_numbers(number_of_numbers) + random_special_chars(number_of_special)

    chars.shuffle.join
  end

  def self.random_passwords(n, config)
    (1..n).map { random_password(config[:letters], config[:numbers], config[:special]) }
  end

  def self.password_to_clipboard(number_of_letters, number_of_numbers, number_of_special)
    password = random_password(number_of_letters, number_of_numbers, number_of_special)
    Clipboard.copy password
    password
  end
end
