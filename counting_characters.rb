module CountingCharacters
  def self.count_chars
    puts 'What is the input string? '
    string = gets

    if string.empty?
      puts 'You must enter a non empty string.'
    else
      puts "#{string} has #{string.length} characters."
    end
  end
end
