class DrivingAgeCalculator
  DEFAULTS = {
    uk: 17,
    fra: 18,
    ger: 18
  }

  def initialize(country_map = nil)
    if country_map.nil?
      @driving_ages = DEFAULTS
    else
      @driving_ages = country_map
    end
  end

  def drive?(age, limit)
    raise ArgumentError unless (age.is_a?(Numeric) && limit.is_a?(Numeric))
    raise ArgumentError if age.negative?

    age >= limit
  end

  def driving_age(country)
    @driving_ages[country]
  end

  def drive_in?(age, country)
    raise CountryNotFoundError if driving_age(country).nil?

    drive?(age, driving_age(country))
  end
end

class CountryNotFoundError < StandardError
end
