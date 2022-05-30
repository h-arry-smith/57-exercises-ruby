require_relative '../password_strength'

RSpec.describe '#password_strength' do
  it 'gives a strength of zero for a password <8 and only numbers' do
    expect(password_strength('012345')).to eq(0)
  end

  it 'gives a strength of one if <8 and includes letters' do
    expect(password_strength('abcdef')).to eq(1)
  end

  it 'gives a strength of two if includes letters and greater than eight' do
    expect(password_strength('abcdefghi')).to eq(2)
  end

  it 'gives a strength of three if includes numbers and letters' do
    expect(password_strength('abcdef123')).to eq(3)
  end

  it 'gives a strength of four if it includes symbols, numbers and letters' do
    expect(password_strength('abcdef123!')).to eq(4)
  end

  it 'gives a strength of three if has symbol and letters but no numbers' do
    expect(password_strength('abcdefgh$$')).to eq(3)
  end
end
