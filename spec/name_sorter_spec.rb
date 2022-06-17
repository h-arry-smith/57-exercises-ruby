require 'stringio'
require_relative '../name_sorter'

NAMES = [
  'Ling, Mai',
  'Johnson, Jim',
  'Zarnecki, Sabrina',
  'Jones, Chris',
  'Jones, Aaron',
  'Swift, Geoffrey',
  'Xiong, Fong'
]

RSpec.describe '#sort_file' do
  before do
    @in_file = StringIO.new
    @out_file = StringIO.new

    NAMES.each { |name| @in_file.puts name }
    @in_file.seek(0)
  end
  it 'takes the input file, sorts them, and outputs with header to the output file' do
    expected = <<~OUTPUT
Total of 7 names
--------------------
Johnson, Jim
Jones, Aaron
Jones, Chris
Ling, Mai
Swift, Geoffrey
Xiong, Fong
Zarnecki, Sabrina
OUTPUT

    sort_file(@in_file, @out_file)

    expect(@out_file.string).to eq(expected)
  end
end
