require 'json'

class Inventory
  attr_reader :file, :items

  def initialize(file = nil)
    @items = []
    @items = load(file) unless file.nil?
  end

  def add(name, serial_no, price, photo_path = nil)
    @items << Item.new(name, serial_no, price, photo_path)
  end

  def persist(file)
    file.truncate(0)
    file.puts(JSON.generate({ items: @items.map(&:to_h) }))
  end

  private

  def load(file)
    data = file.read

    return [] if data.empty?

    json_data = JSON.parse(data)

    json_data['items'].map do |entry|
      Item.construct_from_json(entry)
    end
  end
end

Item = Struct.new(:name, :serial_no, :price, :photo_path) do
  def self.construct_from_json(json)
    new(
      json['name'],
      json['serial_no'],
      json['price'],
      json['photo_path']
    )
  end
end
