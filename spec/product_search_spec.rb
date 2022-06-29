require 'fileutils'
require 'json'
require_relative '../product_search'

PATH = 'product_data.json'

RSpec.describe ProductDatabase do
  it 'has the required attributes' do
    db = ProductDatabase.new

    expect(db).to be_a ProductDatabase
    expect(db.products).to eq([])
  end

  it 'given a file path loads the json object into products' do
    db = ProductDatabase.new

    db.load(PATH)

    expect(db.products).to_not eq([])
    expect(db.products.length).to eq(3)
  end

  describe '#search' do
    it 'returns a product by name' do
      db = ProductDatabase.new
      db.load(PATH)
      expected = {
        'name' => 'Widget',
        'price' => 25.00,
        'quantity' => 5
      }

      expect(db.search('Widget')).to eq(expected)
    end
  end

  describe '#add_product' do
    it 'given correct values adds a product to the database' do
      db = ProductDatabase.new
      expected = {
        'name' => 'Test Product',
        'price' => 123.456,
        'quantity' => 789
      }

      db.add_product('Test Product', 123.456, 789)

      expect(db.products.first).to eq(expected)
    end

    it 'raises a type error if quantity or price is non-numeric' do
      db = ProductDatabase.new

      expect { db.add_product('test', 'woops', 1)}.to raise_exception(TypeError)
      expect { db.add_product('test', 1, 'woops')}.to raise_exception(TypeError)
    end
  end

  describe '#save' do
    it 'given a path, saves the correct json to a file' do
      db = ProductDatabase.new
      db.load(PATH)

      db.save('test_data.json')

      original_json = JSON.load_file('product_data.json')
      saved_json = JSON.load_file('test_data.json')

      expect(saved_json).to eq(original_json)
    end

    after do
      FileUtils.rm_rf('test_data.json')
    end
  end
end
