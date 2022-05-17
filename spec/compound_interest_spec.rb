require_relative "../compound_interest"

RSpec.describe InterestCalculator do
  it 'calculates compound interest' do
    expect(InterestCalculator.compound(1500, 4.3, 6, 4)).to eq(1938.84)
  end

  it 'rejects any non-numeric input' do
    expect { InterestCalculator.compound('a', 4.3, 6, 4) }.to raise_exception(ArgumentError)
    expect { InterestCalculator.compound(1500, 'b', 6, 4) }.to raise_exception(ArgumentError)
    expect { InterestCalculator.compound(1500, 4.3, 'c', 4) }.to raise_exception(ArgumentError)
    expect { InterestCalculator.compound(1500, 4.3, 6, 'd') }.to raise_exception(ArgumentError)
  end

  it 'calculates amount to invest given a target and all other paramaters' do
    expect(InterestCalculator.how_much?(1938.84, 4.3, 6, 4)).to eq(1500)
  end
end
