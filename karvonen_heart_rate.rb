class HeartRateTable
  attr_reader :age, :resting_rate

  def initialize(age, resting_rate)
    raise TypeError if [age, resting_rate].any? { |x| !x.is_a? Numeric }

    @age = age
    @resting_rate = resting_rate
  end

  def rate_at_intensity(intensity)
    ((((220 - @age) - @resting_rate) * intensity) + @resting_rate).round
  end

  def table(start, finish)
    (start..finish).step(5).map do |intensity|
      HRTTableRow.new(
        intensity,
        rate_at_intensity(intensity / 100.0)
      )
    end
  end
end

class HRTTableRow
  attr_reader :intensity, :target_rate

  def initialize(intensity, target_rate)
    @intensity = "#{intensity}%"
    @target_rate = "#{target_rate}bpm"
  end

  def [](sym)
    instance_variable_get("@#{sym}")
  end
end

class TablePrinter
  attr_reader :symbols, :data
  LPAD = 1
  RPAD = 3
  DIVIDER = "|"

  def initialize(symbols, data)
    @symbols = symbols
    @data = data
  end

  def put_header
    puts full_header
  end

  def put_divider
    puts '-' * full_header.length
  end

  def put_data(data)
    content = @symbols.map do |sym|
      content = data[sym]
      width = header(sym).length
      "#{' ' * LPAD}#{content}".ljust(width, ' ')
    end

    puts content.join(DIVIDER)
  end

  def put_table
    put_header
    put_divider
    @data.each { |d| put_data d }
  end

  private

  def full_header
    @symbols.map { |sym| header sym }.join(DIVIDER)
  end

  def title(sym)
    sym.to_s.split('_').map { |s| s.capitalize  }.join(' ')
  end

  def header(sym)
    "#{' ' * LPAD}#{title(sym)}#{' ' * RPAD}"
  end
end
