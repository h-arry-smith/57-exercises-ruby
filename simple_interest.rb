class InterestCalculator
  def self.interest(principal, interest, number_of_years)
    raise ArgumentError unless principal.is_a? Numeric
    raise ArgumentError unless interest.is_a? Numeric
    raise ArgumentError unless number_of_years.is_a? Numeric

    (principal * (1 + (interest / 100.0) * number_of_years)).ceil(2)
  end

  def self.interest_series(principal, interest, number_of_years)
    (1..number_of_years).map do |year|
      interest(principal, interest, year)
    end
  end
end
