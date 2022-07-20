require 'stringio'
require_relative '../inventory'

EXAMPLE_TEXT = <<-TEXT
{
    "items": [
          { "name": "Playstation 4", "serial_no": "ABC-1234-XY12", "price": 599.99 },
          { "name": "DSLR Camera", "serial_no": "XYZ1111ABC", "price": 3250.00 },
          { "name": "Television", "serial_no": "DEFXYZABC", "price": 1250.00 }
     ]
}
TEXT

RSpec.describe Inventory do
  it 'takes a file handler and has a list of items' do
    test_file = StringIO.new
    inv = Inventory.new(test_file)

    expect(inv.items).to eq([])
  end

  it 'when a file has some contents it will load the contents into the items list' do
    test_file = StringIO.new
    test_file.puts(EXAMPLE_TEXT)
    test_file.seek(0)

    inv = Inventory.new(test_file)

    expect(inv.items).to eq([
      Item.new("Playstation 4", "ABC-1234-XY12", 599.99),
      Item.new("DSLR Camera", "XYZ1111ABC", 3250.00),
      Item.new("Television", "DEFXYZABC", 1250.00)
    ])
  end

  it 'adding a new entry adds it to the item list but also persists it to the file' do
    test_file = StringIO.new
    inv = Inventory.new(test_file)

    inv.add('Test Item', 'ABC123DEF', 123.456, 'image/path/here.png')

    expect(inv.items).to eq([
      Item.new('Test Item', 'ABC123DEF', 123.456, 'image/path/here.png')
    ])
  end

  it 'can persist the inventory back to the file' do
    test_file = StringIO.new
    inv = Inventory.new
    inv.add('Test Item', 'ABC123DEF', 123.456, 'image/path/here.png')

    inv.persist(test_file)

    expect(test_file.string).to eq(<<-EXPECTED
{"items":[{"name":"Test Item","serial_no":"ABC123DEF","price":123.456,"photo_path":"image/path/here.png"}]}
EXPECTED
    )
  end

  it 'persisting in a file with any contents totally rewrites the file' do
    test_file = StringIO.new("some contents in this file\n")
    inv = Inventory.new
    inv.add('Test Item', 'ABC123DEF', 123.456, 'image/path/here.png')

    inv.persist(test_file)

    expect(test_file.string).to eq(<<-EXPECTED
{"items":[{"name":"Test Item","serial_no":"ABC123DEF","price":123.456,"photo_path":"image/path/here.png"}]}
EXPECTED
    )
  end
end

RSpec.describe Item do
  it 'has the correct attributes' do
    item = Item.new('Playstation 4', 'ABC-1234-XY12', 599.99)

    expect(item.name).to eq('Playstation 4')
    expect(item.serial_no).to eq('ABC-1234-XY12')
    expect(item.price).to eq(599.99)
  end

  it 'has an optional photo path' do
    item = Item.new('Playstation 4', 'ABC-1234-XY12', 599.99, 'images/ps4.png')

    expect(item.name).to eq('Playstation 4')
    expect(item.serial_no).to eq('ABC-1234-XY12')
    expect(item.price).to eq(599.99)
    expect(item.photo_path).to eq('images/ps4.png')
  end
end
