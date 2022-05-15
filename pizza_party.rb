class PizzaParty
  attr_reader :people, :pizzas

  SLICES_PER_PIZZA = 8

  def initialize(people, pizzas)
    raise ArgumentError unless (people.is_a?(Integer) && pizzas.is_a?(Integer))

    @people = people
    @pizzas = pizzas
  end

  def slices_per_person
    total_slices / @people
  end

  def leftovers
    total_slices - total_slices_eaten
  end

  def pizzas_for_n_slices(slices)
    ((slices * @people) / SLICES_PER_PIZZA.to_f).ceil
  end

  def print_pieces
    puts "#{slices_per_person} piece#{slices_per_person > 1 ? 's' : ''}"
  end

  private

  def total_slices
    @pizzas * SLICES_PER_PIZZA
  end

  def total_slices_eaten
    (@people * slices_per_person)
  end
end
