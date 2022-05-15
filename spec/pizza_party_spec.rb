require_relative '../pizza_party'

RSpec.describe PizzaParty do
  it 'has x pizzas and y people at a party' do
    party = PizzaParty.new(8, 2)

    expect(party.people).to eq(8)
    expect(party.pizzas).to eq(2)
  end

  it 'does not allow non-integer input' do
    expect { PizzaParty.new('a', 5) }.to raise_exception(ArgumentError)
    expect { PizzaParty.new(5, 'a') }.to raise_exception(ArgumentError)
    expect { PizzaParty.new(5.5, 3.2) }.to raise_exception(ArgumentError)
  end

  it 'calculates the correct number of slices per person' do
    party = PizzaParty.new(8, 2)

    expect(party.slices_per_person).to eq(2)
  end

  it 'calculates the correct number of slices when it can not be evenly divided' do
    party = PizzaParty.new(12, 2)

    expect(party.slices_per_person).to eq(1)
  end

  it 'calculates any leftover pizza' do
    no_leftovers = PizzaParty.new(8, 2)
    leftovers = PizzaParty.new(12, 2)

    expect(no_leftovers.leftovers).to eq(0)
    expect(leftovers.leftovers).to eq(4)
  end

  it 'given a target number of slices, returns the minimum number of pizzas to buy' do
    party = PizzaParty.new(7, 2)

    expect(party.pizzas_for_n_slices(4)).to eq(4)
  end

  it 'displays correctly pluralised output for how many pieces people get' do
    plural = PizzaParty.new(8, 2)
    singular = PizzaParty.new(8, 1)

    expect { plural.print_pieces }.to output("2 pieces\n").to_stdout
    expect { singular.print_pieces }.to output("1 piece\n").to_stdout
  end
end
