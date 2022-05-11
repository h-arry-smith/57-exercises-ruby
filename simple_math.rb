module SimpleMath
  def self.gets_number(name = '')
    prompt_user name

    user_input = gets.chomp.strip
    value = user_input.to_i

    if value.negative?
      puts 'Negative numbers are not allowed.'
      nil
    elsif !is_integer?(user_input)
      puts 'You must enter a number.'
      nil
    else
      value
    end
  end

  def self.prompt_user(name)
    if name != ''
      puts "What is the #{name} number? "
    else
      puts 'What is the number? '
    end
  end

  def self.display_computation(a, b)
    output = <<~OUTPUT
    #{a} + #{b} = #{add(a, b)}
    #{a} - #{b} = #{sub(a, b)}
    #{a} * #{b} = #{mul(a, b)}
    #{a} / #{b} = #{div(a, b)}
OUTPUT

    puts output
  end

  def self.compute_two_numbers
    a = gets_number('first')
    return if a.nil?

    b = gets_number('second')
    return if b.nil?

    display_computation(a, b)
  end

  def self.add(a, b)
    a + b
  end
  def self.sub(a, b)
    a - b
  end
  def self.div(a, b)
    a / b
  end
  def self.mul(a, b)
    a * b
  end

  def self.is_integer?(string)
    string.to_i.to_s == string
  end
end
