require_relative 'inventory'
require_relative 'html_report'

DB_FILE = "inventory.json"

File.open(DB_FILE, 'w') {} unless File.exists?(DB_FILE)

inventory = File.open(DB_FILE) { |file| Inventory.new(file) }

def get_input(prompt)
  print prompt + ' '
  gets.chomp.strip
end

run = true

while run
  add_another = get_input('Do you want to add something to the database? (y/n)').downcase

  if add_another == 'y'
    name = get_input('What is the name of the item?')
    serial_no = get_input('What is the serial number of the item?')
    price = get_input('What is the price of the item?').to_f
    photo_path = get_input('Path to photo of the item (leave blank if none)')

    photo_path = nil if photo_path == ''

    puts 'Adding item to the database...'
    inventory.add(name, serial_no, price, photo_path)
  elsif add_another == 'n'
    run = false
  end
end

puts 'Saving the database...'
File.open(DB_FILE, 'w') { |file| inventory.persist(file) }
puts 'Generating html report...'
HTMLReporter.render(inventory, 'report.erb', 'your_inventory.html')
