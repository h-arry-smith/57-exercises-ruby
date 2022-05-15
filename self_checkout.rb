# In future exercise I need to start breaking out this code from one all encompossing
# class. For example in this code there are many distinct concepts:
#   - The Shopping Basket
#   - The Item
#   - Money as an object
#   - Receipts
#
# Now my familiarity with the language has grown considerably, I will start to
# this much better object oriented style and associated tests. This technique has
# served the learning so far but now it is time to evolve.
#
# For the first time I start to understand the reasoning and rationale behind SOLID
# and how to use OOP to my advantage. This insight has been hard to come by and will
# forever help me structure better, more readable and adaptable code. This book
# already pays for itself.

class ShoppingBasket
  attr_reader :items

  SALES_TAX = 0.055

  def initialize
    @items = []
  end

  def add_item(price, quantity)
    raise ArgumentError unless price.is_a? Numeric
    raise ArgumentError unless quantity.is_a? Numeric

    @items << { price: to_cents(price), quantity: quantity }
  end

  def subtotal
    @items.reduce(0) { |sum, item| sum + (item[:quantity] * item[:price]) }
  end

  def tax
    (subtotal * SALES_TAX)
  end

  def total
    subtotal + tax
  end

  def receipt
    receipt = []

    items.each_with_index do |item, index|
      receipt << "Item #{index + 1}: #{pretty_print(item[:price])} x #{item[:quantity]}"
    end

    receipt << '--------------------'

    receipt << "Subtotal: #{pretty_print(subtotal)}"
    receipt << "Tax: #{pretty_print(tax)}"
    receipt << "Total: #{pretty_print(total)}"

    receipt << '--------------------'
    receipt << ''

    receipt.join("\n")
  end

  private

  def to_cents(dollars)
    dollars * 100
  end

  def pretty_print(cents)
    format('$%.2f', cents / 100)
  end
end
