Employee = Struct.new(:name, :position, :seperation_date) do
end

class Tabulate
  def self.print(data)
    headers = get_headers(data)
    widths = column_widths(data)

    puts_header(headers, widths)
    puts_hr(widths)
    data.each { |row| puts_row(row, headers, widths) }
  end

  def self.get_headers(data)
    data.first.members
  end

  def self.pretty_header(header_sym)
    header_sym.to_s.split('_').map(&:capitalize).join(' ')
  end

  def self.max_column_width(header, data)
    max = 0

    data.each do |element|
      unless element[header].nil?
        val = element[header].to_s
        max = val.length if val.length > max
      end
    end

    max = pretty_header(header).length if pretty_header(header).length > max

    max
  end

  def self.column_widths(data)
    widths = {}

    data.first.members.each { |header| widths[header] = max_column_width(header, data) }

    widths
  end

  def self.puts_header(headers, widths)
    strings = headers.map do |header|
      pretty_header(header).ljust(widths[header], ' ')
    end

    puts strings.join(' | ')
  end

  def self.puts_hr(widths)
    total = widths.map { |_k, v| v }.sum

    puts '-' * (total + ((widths.length - 1) * 3) + 1)
  end

  def self.puts_row(data_row, headers, widths)
    strings = headers.map do |header|
      data_row[header].to_s.ljust(widths[header], ' ')
    end

    puts strings.join(' | ').strip
  end
end
