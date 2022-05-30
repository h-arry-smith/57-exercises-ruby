require_relative '../comparing_numbers'

RSpec.describe largest_number do
  it 'returns the largest number of a triplet' do
    expect(largest_number(1, 2, 3)).to eq(3)
  end

  it 'works with negative values' do
    expect(largest_number(-5, -4, -3)).to eq(-3)
  end

  it 'handles an unlimited amount of numbers' do
    expect(largest_number(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)).to eq(10)
  end

  it 'raises a TypeError if any argument is non numeric' do
    expect { largest_number(1, 'a', 2) }.to raise_exception(TypeError)
  end

  it 'raises a NonUniqueError if any value is repeated' do
    expect { largest_number(1, 2, 2, 3, 4, 5, 2) }.to raise_exception(NonUniqueError)
  end
end

RSpec.describe set? do
  it 'returns true if a unique set' do
    expect(set?(1, 2, 3)).to eq(true)
  end

  it 'returns false if non-unique' do
    expect(set?(1, 2, 2, 3)).to eq(false)
  end
end
