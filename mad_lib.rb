class MadLibGenerator
  attr_accessor :format
  attr_reader :elements

  def initialize(elements = %w[verb adjective noun adverb], format = "Do you %s your %s %s %s? That's hilarious!")
    raise BadFormatString if placeholder_count(format) != elements.length
    @elements = []

    elements.each do |element|
      self.class.send(:attr_accessor, element.to_sym)
      instance_variable_set("@#{element}", '')

      @elements << element
    end

    @format = format
  end

  def set_element_to_user_input(element)
    raise NoElementError unless instance_variable_defined?("@#{element}")

    puts "Enter a #{element}: "
    value = gets.chomp.strip

    instance_variable_set("@#{element}", value)
  end

  def get_mad_lib_from_user
    @elements.each do |element|
      set_element_to_user_input(element)
    end
  end

  def print_mad_lib
    element_strings = @elements.map { |element| instance_variable_get("@#{element}") }
    puts @format % element_strings
  end

  private

  def placeholder_count(format)
    format.scan(/%s/).count
  end
end

class NoElementError < StandardError
end

class BadFormatString < StandardError
end
