require_relative '../tax_calculator'

RSpec.describe TaxCalculator do
  it 'calculates the tax for wisconsin residents on a sale' do
    expect(TaxCalculator.tax(1000, 'WI')).to eq(55)
  end

  it 'calculates the tax for non-wisconsin residents on a sale' do
    expect(TaxCalculator.tax(1000, 'NY')).to eq(0)
  end

  it 'calculates tax correctly regardles of how state is inputted' do
    variations = ['WI', 'wi', 'Wi', 'wisconsin', 'WISCONSIN', 'wiSconSiN']

    variations.each do |state|
      expect(TaxCalculator.tax(1000, state)).to eq(55)
    end
  end
end
