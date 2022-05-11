class RetirementCalculator
  attr_accessor :age, :retirement_age

  def initialize(age = 0, retirement_age = 0)
    @age = age
    @retirement_age = retirement_age
  end

  def years_until_retirement
    @retirement_age - @age
  end

  def can_retire?
    years_until_retirement <= 0
  end

  def retirement_year(year = nil)
    year = current_year if year.nil?

    year + years_until_retirement
  end

  def current_year
    Time.new.year
  end

  def display
    if can_retire?
      output = <<~OUTPUT
    Your age is: #{@age}
    You want to retire when you are: #{@retirement_age}
    You can already retire!
    OUTPUT
    else
      output = <<~OUTPUT
    Your age is: #{@age}
    You want to retire when you are: #{@retirement_age}
    You have #{years_until_retirement} years until you can retire
    It is #{current_year}, so you can retire in #{retirement_year}
    OUTPUT
    end

    puts output
  end
end
