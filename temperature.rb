class Temperature
  attr_reader :unit

  def initialize(temperature, unit)
    raise TypeError unless temperature.is_a? Numeric

    @temperature = temperature
    @unit = unit
  end

  def celsius
    convert(:c)
  end

  def farenheit
    convert(:f)
  end

  def kelvin
    convert(:k)
  end

  def self.celsius(temperature)
    new(temperature, :c)
  end

  def self.farenheit(temperature)
    new(temperature, :f)
  end

  def self.kelvin(temperature)
    new(temperature, :k)
  end

  def convert(target_unit)
    return @temperature if @unit == target_unit

    send("#{@unit}_to_#{target_unit}".to_sym, @temperature)
  end

  private

  def c_to_f(celsius)
    (celsius * (9.0 / 5.0)) + 32
  end

  def c_to_k(celsius)
    celsius + 273.15
  end

  def f_to_c(farenheit)
    (farenheit - 32.0) * (5.0 / 9.0)
  end

  def f_to_k(farenheit)
    f_to_c(farenheit) + 273.15
  end

  def k_to_c(kelvin)
    kelvin - 273.15
  end

  def k_to_f(kelvin)
    c_to_f(k_to_c(kelvin))
  end
end
