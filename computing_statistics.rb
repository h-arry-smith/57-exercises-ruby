class DataSet
  attr_reader :data

  def initialize
    @data = []
  end

  def record(*ms)
    raise TypeError unless ms.all? { |time| time.is_a? Numeric }

    ms.each { |time| @data << time }
  end

  def get_user_input
    print 'Enter a number: '
    user_input = gets.chomp

    return user_input if user_input == 'done'

    user_input.to_i
  end

  def get_dataset
    user_input = nil

    until user_input == 'done'
      user_input = get_user_input
      record user_input if user_input != 'done'
    end
  end

  def mean
    (@data.sum / @data.length.to_f).round(2)
  end

  def max
    @data.max
  end

  def min
    @data.min
  end

  def standard_deviation
    m = @data.sum / @data.length.to_f
    sum = @data.sum(0.0) { |time| (time - m)**2 }
    Math.sqrt(sum / (@data.size - 1)).round(2)
  end
end
