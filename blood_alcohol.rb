# Thinking in an OOP way, would extract User and Drink objects out from this, but
# leaving as an exercise for the imagination. If this was more fully featured, this
# would seperate the concerns nicely. Don't want to get bogged down in any exercise
# for too long but good to notice.

class BloodAlcoholCalculator
  attr_reader :ratio, :drinks, :weight

  ALCOHOL_DISTRIBUTION_RATIOS = {
    male: 0.73,
    female: 0.66
  }

  DEFAULT_BODY_WEIGHTS = {
    male: 197.9,
    female: 167.6
  }

  def initialize(gender)
    @ratio = ALCOHOL_DISTRIBUTION_RATIOS[gender]
    @weight = DEFAULT_BODY_WEIGHTS[gender]
    @drinks = []
  end

  def add_drink(oz, time = Time.now)
    raise ArgumentError if oz <= 0

    @drinks << {oz: oz, time: time}
  end

  def hours_since_last_drink
    return 0 if @drinks == []

    ((Time.now - @drinks.last[:time]) / (1 * 60 * 60)).round
  end

  def total_alcohol
    @drinks.reduce(0) do |sum, drink|
      sum + drink[:oz]
    end
  end

  def bac
    ((total_alcohol * 5.14 / @weight * @ratio) - 0.015 * hours_since_last_drink).round(3)
  end

  def drive?
    bac < 0.08
  end
end
