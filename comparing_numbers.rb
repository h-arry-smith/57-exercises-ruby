def largest_number(*numbers)
  raise TypeError if numbers.any? { |n| !n.is_a? Numeric }
  raise NonUniqueError unless set?(*numbers)

  max = nil
  numbers.each do |n|
    max = n if max.nil? || n > max
  end

  max
end

def set?(*numbers)
  numbers.uniq.length == numbers.length
end

class NonUniqueError < StandardError
end
