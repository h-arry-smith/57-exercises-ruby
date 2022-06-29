require 'stringio'
require_relative '../word_frequency_finder'

TEXT = 'badger badger badger badger mushroom mushroom snake badger badger badger'

RSpec.describe '#count_words' do
  before do
    @file = StringIO.new(TEXT)
  end

  it 'counts every word in a supplied file' do
    expected = {
      'badger' => 7,
      'mushroom' => 2,
      'snake' => 1
    }

    expect(count_words(@file)).to eq(expected)
  end
end

RSpec.describe '#show_word_frequencies' do
  it 'outputs correctly formatted frequencies' do
    data = { 'longer' => 3, 'short' => 2 }
    expected = <<~OUTPUT
longer: ***
short:  **
OUTPUT

    expect { show_word_frequencies(data) }.to output(expected).to_stdout
  end

  it 'sorts data from largest to smalles' do
    data = { 'two' => 2, 'one' => 1, 'three' => 3}
    expected = <<~OUTPUT
three: ***
two:   **
one:   *
OUTPUT

    expect { show_word_frequencies(data) }.to output(expected).to_stdout
  end
end
