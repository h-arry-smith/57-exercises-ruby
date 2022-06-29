require 'json'

class ProductDatabase
  attr_reader :products

  def initialize
    @products = []
  end

  def load(path)
    @products = JSON.load_file(path)["products"]
  end

  def save(path)
    data = { "products" => @products }
    File.open(path, 'w') { |file| file.write(JSON.generate(data)) }
  end

  def search(name)
    @products.find { |product| product["name"] == name }
  end

  def add_product(name, price, quantity)
    raise TypeError unless [price, quantity].all? { |arg| arg.is_a? Numeric }

    @products << {
      'name' => name,
      'price' => price,
      'quantity' => quantity
    }
  end
end
