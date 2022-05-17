require_relative '../currency_conversion'

RSpec.describe CurrencyCalculator do
  it 'given an exchange rate and unit amount converts to the new currency' do
    calc = get_mocked_calculator

    expect(calc.convert(81, 137.51, 100.0)).to eq(111.38)
  end

  it 'given a unit and two currencies will convert between them' do
    calc = get_mocked_calculator

    expect(calc.exchange('USD', 'AED', 100)).to eq(367.25)
  end

  it 'if a unit is given that does not exist it will raise an error' do
    calc = get_mocked_calculator

    expect { calc.exchange('ABC', 'DEF', 100) }.to raise_exception(CurrencyDoesNotExistError)
  end

  it 'handles mixed case identifiers' do
    calc = get_mocked_calculator

    expect(calc.exchange('usD', 'aEd', 100)).to eq(367.25)
  end
end

def get_mocked_calculator
  CurrencyCalculator.new(RatesProvider.new(MockAPI.new('test-key-not-real')))
end

class MockAPI
  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_rates(base)
    {
      'diclaimer' => 'https://openexchangerates.org/terms/',
      'license' => 'https://openexchangerates.org/license/',
      'timestamp' => 1_449_877_801,
      'base' => base,
      'rates' => {
        'AED' => 3.672538,
        'AFN' => 66.809999,
        'ALL' => 125.716501,
        base => 1
      }
    }
  end

  def fetch_currencies
    {
      'AED' => 'United Arab Emirates Dirham',
      'AFN' => 'Afghan Afghani',
      'ALL' => 'Albanian Lek',
      'USD' => 'United States Dollar'
    }
  end
end
