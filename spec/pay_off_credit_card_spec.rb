require_relative '../pay_off_credit_card'

RSpec.describe '#months_to_pay_off' do
  it 'calcualates number of months to pay off credit card debt' do
    expect(months_to_pay_off(5000.0, 12.0, 100.0)).to eq(70)
  end
end
