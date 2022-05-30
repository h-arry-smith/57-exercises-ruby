class Height
  attr_reader :value

  CM_PER_INCH = 2.54

  def initialize(height)
    @value = height
  end

  def self.cm(height)
    new(height)
  end

  def self.inches(height)
    new(height * CM_PER_INCH)
  end

  def ==(other)
    @value == other.to_i
  end

  def /(other)
    @value / other.to_f
  end

  def *(other)
    @value * other.to_f
  end

  def to_i
    @value
  end

  def to_f
    @value.to_f
  end

  def coerce(other)
    [@value, other.to_f]
  end
end

class Weight
  attr_reader :value

  LB_PER_KG = 2.20462

  def initialize(weight)
    @value = weight
  end

  def self.kg(weight)
    new(weight)
  end

  def self.lb(weight)
    new((weight / LB_PER_KG).round(2))
  end

  def ==(other)
    @value == other.to_i
  end

  def /(other)
    @value / other.to_f
  end

  def *(other)
    @value * other.to_f
  end

  def to_i
    @value
  end

  def to_f
    @value.to_f
  end

  def coerce(other)
    [@value, other.to_f]
  end
end

class Person
  attr_reader :height, :weight

  def initialize(height, weight)
    @height = height
    @weight = weight
  end

  def bmi
    ((@weight / (@height * @height)) * 10_000).round(2)
  end

  def overweight?
    bmi > 25.0
  end
end
