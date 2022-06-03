require_relative '../handling_bad_input'

RSpec.describe '#rate_of_return' do
  it 'returns the rate of return with valid user input' do
    allow_any_instance_of(Object).to receive(:gets).and_return('4')

    expect(rate_of_return).to eq(18)
  end

  it 'returns the rate of return when bad inputs are given first' do
    allow_any_instance_of(Object).to receive(:gets).and_return('abcd', '4')

    expect(rate_of_return).to eq(18)
  end

  it 'does not allow 0 as a number for rate calculation' do
    allow_any_instance_of(Object).to receive(:gets).and_return('0', '1')

    expect(rate_of_return).to eq(72)
  end
end
