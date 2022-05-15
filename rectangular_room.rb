class Room
  attr_reader :width, :height

  CONVERSION_FACTOR = 0.09290304
  PRECISION = 3

  def initialize(width, height, unit = :ft)
    raise ArgumentError unless width.is_a?(Numeric) && height.is_a?(Numeric)

    @width = width
    @height = height
    @unit = unit
  end

  def square_footage
    sq_ft.round(PRECISION)
  end

  def square_meterage
    sq_m.round(PRECISION)
  end

  private

  def sq_ft
    return @width * @height if @unit == :ft

    (square_meterage / CONVERSION_FACTOR)
  end

  def sq_m
    return @width * @height if @unit == :m

    (square_footage * CONVERSION_FACTOR)
  end
end
