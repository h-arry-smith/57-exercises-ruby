require_relative '../simple_interest'

RSpec.describe InterestCalculator do
  it 'calculates simple interest' do
    expect(InterestCalculator.interest(1500, 4.3, 4)).to eq(1758)
  end

  it 'does not allow non-numeric inputs' do
    expect { InterestCalculator.interest('a', 4.3, 4) }.to raise_exception(ArgumentError)
    expect { InterestCalculator.interest(1500, 'b', 4) }.to raise_exception(ArgumentError)
    expect { InterestCalculator.interest(1500, 4.3, 'c') }.to raise_exception(ArgumentError)
  end

  it 'calculates the simple interest per year and returns them as an array' do
    expected = [105.0, 110.01, 115]
    expect(InterestCalculator.interest_series(100, 5, 3)).to eq(expected)
  end
end
