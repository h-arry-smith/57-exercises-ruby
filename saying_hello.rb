module SayingHello
  @greetings = {
    'Katie' => '%s! Nice to meet you!'
  }

  def self.greet
    puts 'What is your name? '
    puts get_greeting(gets.chomp)
  end

  def self.get_greeting(name)
    return format(@greetings[name], name) if @greetings.key? name

    "Hello, #{gets}, nice to meet you!"
  end
end
