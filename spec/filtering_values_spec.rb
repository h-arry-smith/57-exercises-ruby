require 'stringio'
require_relative '../filtering_values'

RSpec.describe '#numbers_to_array' do
  it 'takes a string with one number and returns an array containing it as an integer' do
    expect(numbers_to_array('1')).to match_array([1])
  end

  it 'takes a string of numbers seperated by spaces and returns an array of them' do
    expect(numbers_to_array('1 2 3')).to match_array([1, 2, 3])
  end

  it 'given a deliminator, will split by the deliminator' do
    expect(numbers_to_array('1, 2, 3, 4', ', ')).to match_array([1, 2, 3, 4])
  end

  it 'given a deliminator that splits and leaves spaces, handles trimming correctly' do
    expect(numbers_to_array('1, 2, 3, 4', ',')).to match_array([1, 2, 3, 4])
  end

  it 'handles a trailing deliminator correctly' do
    expect(numbers_to_array('1#2#3#    ', '#')).to match_array([1, 2, 3])
  end
end

RSpec.describe '#filter_even_numbers' do
  it 'given an array of numbers, returns a new array with only the even numbers' do
    expect(filter_even_numbers([1, 2, 3, 4, 5, 6])).to match_array([1, 3, 5])
  end
end

RSpec.describe '#file_to_array' do
  it 'given a file with numbers on each line, it returns an array of them' do
    expected = [1, 4, 2, 9, 12, 15]
    file = StringIO.new
    expected.each { |n| file.puts n }
    file.seek(0)

    expect(file_to_array(file)).to match_array(expected)
  end
end
