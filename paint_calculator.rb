class PaintCalculator
  FOOTAGE_PER_GALLON = 250.0

  def self.area_to_gallons(area)
    (area / FOOTAGE_PER_GALLON).ceil
  end

  def self.rectangular_room(width, height)
    area_to_gallons width * height
  end

  def self.circular_room(radius)
    area_to_gallons area_of_circle(radius)
  end

  def self.l_shaped_room(width1, height1, width2, height2)
    area_to_gallons (width1 * height1) + (width2 * height2)
  end

  def self.area_of_circle(radius)
    Math::PI * radius**2
  end
end
