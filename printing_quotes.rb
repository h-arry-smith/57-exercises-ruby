module PrintingQuotes
  def self.quote
    puts 'What is the quote? '
    quote = gets

    puts 'Who said it? '
    author = gets

    print_quote(quote, author)
  end

  def self.print_quotes(quotes)
    quotes.each { |author, quote| print_quote(author, quote) }
  end

  def self.print_quote(author, quote)
    puts author + ' says, "' + quote + '"'
  end
end
