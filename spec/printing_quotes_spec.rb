require_relative '../printing_quotes'

RSpec.describe PrintingQuotes, '#quote' do
  it 'prints the correct string' do
    allow_any_instance_of(Object).to receive(:gets).and_return('test-string')

    expected = <<~EXPECTED
  What is the quote? 
  Who said it? 
  test-string says, "test-string"
    EXPECTED

    expect { PrintingQuotes.quote }.to output(expected).to_stdout
  end
end

RSpec.describe PrintingQuotes, '#print_quotes' do
  it 'lists a hash of author, quote pairs in the correct format' do
    quotes = {
      'Winston Churchill' => 'we will fight them on the beaches',
      'Abraham Lincoln' => 'four score and seven years ago',
      'Seneca' => "vain is the philosopher who's words cures no ail of man"
    }

    expected = <<~EXPECTED
Winston Churchill says, "we will fight them on the beaches"
Abraham Lincoln says, "four score and seven years ago"
Seneca says, "vain is the philosopher who's words cures no ail of man"
EXPECTED

    expect { PrintingQuotes.print_quotes(quotes) }.to output(expected).to_stdout
  end
end
