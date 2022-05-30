require_relative '../anagram_checker'

RSpec.describe '#anagram?' do
  it 'returns false if input strings are different length' do
    expect(anagram?('abc', 'abcd')).to be false
  end

  it 'returns true when strings are identical' do
    expect(anagram?('abc', 'abc')).to be true
  end

  it 'returns true if words are anagrams of each other' do
    expect(anagram?('abc', 'cba')).to be true
    expect(anagram?('tone', 'note')).to be true
  end

  it 'returns false if words are no anagrams of each other' do
    expect(anagram?('abc', 'def')).to be false
  end
end
