require_relative '../multiplication_table'

RSpec.describe '#multiples_row' do
  it 'returns array of multiples for a table row' do
    expected = [0, 5, 10, 15, 20, 25]

    expect(multiples_row(5, 5)).to eq(expected)
  end
end

RSpec.describe '#multiples_table' do
  it 'returns a 2D array of multiples' do
    expected = [
      [0, 0, 0, 0],
      [0, 1, 2, 3],
      [0, 2, 4, 6],
      [0, 3, 6, 9]
    ]

    expect(multiples_table(3)).to eq(expected)
  end
end

RSpec.describe '#print_table' do
  it 'outputs a multiplication table' do
    expected = <<OUTPUT
   0   0   0   0
   0   1   2   3
   0   2   4   6
   0   3   6   9
OUTPUT

    expect { print_table(3) }.to output(expected).to_stdout
  end
end
