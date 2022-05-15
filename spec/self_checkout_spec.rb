require_relative '../self_checkout'

RSpec.describe ShoppingBasket do
  before do
    @cart = ShoppingBasket.new
  end

  it 'starts with an empty cart of items' do
    expect(@cart.items).to eq([])
  end

  it 'you can add items to the cart' do
    @cart.add_item(25, 2)
    @cart.add_item(10, 1)
    @cart.add_item(4, 1)

    expected = [
      { price: 2500, quantity: 2 },
      { price: 1000, quantity: 1 },
      { price: 400, quantity: 1 }
    ]

    expect(@cart.items).to eq(expected)
  end

  it 'you can not provide no numeric values for price and quantity' do
    expect { @cart.add_item('h', 4) }.to raise_exception(ArgumentError)
    expect { @cart.add_item(3, 'h') }.to raise_exception(ArgumentError)
  end

  context 'with items from the example' do
    before do
      @cart.add_item(25, 2)
      @cart.add_item(10, 1)
      @cart.add_item(4, 1)
    end

    it 'calculates the subtotal of the cart in cents' do
      expect(@cart.subtotal).to eq(6400)
    end

    it 'calculates the tax of the cart in cents' do
      expect(@cart.tax).to eq(352)
    end

    it 'calculates the total of the cart in cents' do
      expect(@cart.total).to eq(6752)
    end
  end

  describe 'getting the receipt string' do
    before do
      @cart.add_item(25, 2)
    end

    it 'returns a correctly formatted string for simple case' do
      expected = <<~EXPECTED
Item 1: $25.00 x 2
--------------------
Subtotal: $50.00
Tax: $2.75
Total: $52.75
--------------------
EXPECTED

      expect(@cart.receipt).to eq(expected)
    end
  end
end
