require_relative '../multistate_tax_calculator'

RSpec.describe TaxCalculator do
  describe 'calculating sales tax' do
    it 'handles state level default case' do
      expected = SalesReceipt.new(1000, 50)
      expect(TaxCalculator.tax_for(1000, :wisconsin)).to eq(expected)
    end

    it 'handles state and county tax' do
      expected = SalesReceipt.new(1000, 55)
      expect(TaxCalculator.tax_for(1000, :wisconsin, :eau_claire)).to eq(expected)
    end

    it 'handles state with default county tax' do
      expected = SalesReceipt.new(1000, 50)
      expect(TaxCalculator.tax_for(1000, :wisconsin, :polk)).to eq(expected)
    end

    it 'handles with no state or county given' do
      expected = SalesReceipt.new(1000, 0)
      expect(TaxCalculator.tax_for(1000)).to eq(expected)
    end

    it 'handles state abbreviations and mixed case well' do
      expected = SalesReceipt.new(1000, 55)
      expect(TaxCalculator.tax_for(1000, "WI", "eau CLairE")).to eq(expected)
    end
  end

  describe '#normalise_name' do
    it 'handles upper and mixed case state symbols' do
      expect(TaxCalculator.normalise_name(:WISCONSIN)).to eq(:wisconsin)
      expect(TaxCalculator.normalise_name(:WIscONsin)).to eq(:wisconsin)
    end

    it 'handles lower, upper and mixed case state strings' do
      expect(TaxCalculator.normalise_name('wisconsin')).to eq(:wisconsin)
      expect(TaxCalculator.normalise_name('WISCONSIN')).to eq(:wisconsin)
      expect(TaxCalculator.normalise_name('wisCONsin')).to eq(:wisconsin)
    end

    it 'expands state abbreviations to its full name' do
      expect(TaxCalculator.normalise_name('WI')).to eq(:wisconsin)
      expect(TaxCalculator.normalise_name('wi')).to eq(:wisconsin)
      expect(TaxCalculator.normalise_name('Wi')).to eq(:wisconsin)
      expect(TaxCalculator.normalise_name(:WI)).to eq(:wisconsin)
      expect(TaxCalculator.normalise_name(:wi)).to eq(:wisconsin)
      expect(TaxCalculator.normalise_name(:wI)).to eq(:wisconsin)
    end

    it 'returns a short symbol if it is not a state' do
      expect(TaxCalculator.normalise_name(:fgt)).to eq(:fgt)
      expect(TaxCalculator.normalise_name('FGT')).to eq(:fgt)
    end

    it 'replaces spaces with underscores' do
      expect(TaxCalculator.normalise_name('eaU clAiRe')).to eq(:eau_claire)
    end
  end

  describe '#tax_for_state_county' do
    it 'returns the correct tax for a given state' do
      expect(TaxCalculator.tax_for_state_county(:wisconsin)).to eq(0.05)
      expect(TaxCalculator.tax_for_state_county(:illinois)).to eq(0.08)
    end

    it 'returns the correct tax for a default state' do
      expect(TaxCalculator.tax_for_state_county(:texas)).to eq(0)
    end

    it 'returns the correct tax for a state, county pair' do
      expect(TaxCalculator.tax_for_state_county(:wisconsin, :eau_claire
      )).to eq(0.055)
    end

    it 'returns zero when no state or county is given' do
      expect(TaxCalculator.tax_for_state_county).to eq(0)
    end
  end
end

RSpec.describe SalesReceipt do
  it 'is a struct with the correct values' do
    receipt = SalesReceipt.new(1, 2)

    expect(receipt.amount).to eq(1)
    expect(receipt.tax).to eq(2)
  end
end
