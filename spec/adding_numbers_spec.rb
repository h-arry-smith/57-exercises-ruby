require_relative '../adding_numbers'

RSpec.describe '#sum_user_total' do
  it 'when a user specifies one number returns the correct sum' do
    allow_any_instance_of(Object).to receive(:gets).and_return('1', '2')

    expect(sum_user_total).to eq(2)
  end

  it 'handles multiple requested numbers' do
    allow_any_instance_of(Object).to receive(:gets).and_return('3', '2', '3', '4')

    expect(sum_user_total).to eq(9)
  end

  it 'handles complex input with multiple mistakes' do
    allow_any_instance_of(Object).to receive(:gets).and_return('test', '3', 'oops', '2', '3', 'example', 'abcd', '4')

    expect(sum_user_total).to eq(9)
  end
end
RSpec.describe '#gets_n_numbers' do
  it 'returns an array of the requested numbers' do
    allow_any_instance_of(Object).to receive(:gets).and_return('1', '2', '3', '4')

    expect(gets_n_numbers(4)).to eq([1, 2, 3, 4])
  end
end

RSpec.describe '#gets_i' do
  it 'returns an integer' do
    allow_any_instance_of(Object).to receive(:gets).and_return('3')

    expect(gets_i).to eq(3)
  end

  it 'prompts for user input when supplied' do
    allow_any_instance_of(Object).to receive(:gets).and_return('3')

    expect { gets_i('Enter a number: ') }.to output(/Enter a number: /).to_stdout
  end

  it 'will continually request a number until one is given' do
    allow_any_instance_of(Object).to receive(:gets).and_return('four', 'hello', '122')

    expect(gets_i).to eq(122)
  end
end
