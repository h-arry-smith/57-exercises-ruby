require 'stringio'
require_relative '../word_finder'

WORDS = [
  'utilize use',
  'propogate spread',
  'prevent stop'
]

INPUT_TEXT = <<~TEXT
One should never use the word "utilize" in
writing. Use "use" instead.
TEXT

RSpec.describe WordFinder do
  it 'create an instance with the correct attributes' do
    wf = WordFinder.new

    expect(wf.words).to eq({})
  end

  it 'assign a map of bad words to good words to the word finder' do
    wf = WordFinder.new
    config = { 'utilize' => 'use' }

    wf.words = config

    expect(wf.words).to eq(config)
  end

  describe '#add_word' do
    it 'can add a new word to be replaced' do
      wf = WordFinder.new
      expected = { 'utilize' => 'use' }

      wf << %w[utilize use]

      expect(wf.words).to eq(expected)
    end
  end

  describe '#load_config' do
    before do
      @config_file = StringIO.new
      WORDS.each { |line| @config_file.puts line }
      @config_file.seek(0)
    end

    it 'given a file name, loads a config file into the words map' do
      allow(File).to receive(:open).with('test.txt').and_return(@config_file)
      expected = {
        'utilize' => 'use',
        'propogate' => 'spread',
        'prevent' => 'stop'
      }

      wf = WordFinder.new

      wf.load_config('test.txt')

      expect(wf.words).to eq(expected)
    end
  end

  describe '#replace_file' do
    before do
      @input_file = StringIO.new(INPUT_TEXT)
      @output_file = StringIO.new

      allow(File).to receive(:open).with('input.txt').and_return(@input_file)
      allow(File).to receive(:open).with('output.txt').and_return(@output_file)
    end

    it 'takes a input file and an outputs the replacement to a new file' do
      wf = WordFinder.new
      wf << %w[utilize use]
      expected = <<~OUTPUT
One should never use the word "use" in
writing. Use "use" instead.
OUTPUT

      wf.replace_file('input.txt', 'output.txt')

      expect(@output_file.string).to eq(expected)
    end

    it 'returns a hash of statistics for words replaced' do
      wf = WordFinder.new
      wf << %w[utilize use]
      expected = {
        'utilize' => 2
      }

      expect(wf.replace_file('input.txt', 'output.txt')).to eq(expected)
    end
  end
end
