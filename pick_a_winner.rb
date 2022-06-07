class Lottery
  attr_reader :names

  def initialize
    @names = []
  end

  def add_name(name)
    @names << name
  end

  def get_name_from_user
    print "Enter a name: "
    gets.chomp.strip
  end

  def add_name_from_user
    @names << get_name_from_user
  end

  def populate_names_with_user_input
    add_name_from_user until blank_line_entered
  end

  def select_winner
    return nil if no_more_entries

    @names.delete_at(rand(0..@names.length - 1))
  end

  def present_all_winners
    count = 0
    puts "Winner #{count += 1} is... #{select_winner}!" until no_more_entries
  end

  private

  def no_more_entries
    @names.empty?
  end

  def blank_line_entered
    if @names.last == ''
      @names.pop
      true
    else
      false
    end
  end
end
