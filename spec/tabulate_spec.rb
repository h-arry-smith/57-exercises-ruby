require 'date'
require_relative '../tabulate'

EMPLOYEES = [
  Employee.new('Jacquelyn Jackson', 'DBA', nil),
  Employee.new('Jake Jacobson', 'Programmer', nil),
  Employee.new('John Johnson', 'Manager', Date.parse('2016-12-31'))
]

RSpec.describe Tabulate do
  describe '#print' do
    it 'given an array of like data structures, outputs a correctly formatted table' do
      expected = <<~OUTPUT
Name              | Position   | Seperation Date
-------------------------------------------------
Jacquelyn Jackson | DBA        |
Jake Jacobson     | Programmer |
John Johnson      | Manager    | 2016-12-31
OUTPUT

      expect { Tabulate.print(EMPLOYEES) }.to output(expected).to_stdout
    end
  end

  describe '#get_headers' do
    it 'given an array of data, returns an array of symbols for each column' do
      expect(Tabulate.get_headers(EMPLOYEES)).to eq([:name, :position, :seperation_date])
    end
  end

  describe '#pretty_header' do
    it 'returns a symbol as a capatilised string' do
      expect(Tabulate.pretty_header(:hello)).to eq('Hello')
    end

    it 'a symbol with underscores treated as multiple words' do
      expect(Tabulate.pretty_header(:hello_world)).to eq('Hello World')
    end
  end

  describe '#max_column_width' do
    it 'given a header and a set of data returns the max width for a column' do
      expect(Tabulate.max_column_width(:name, EMPLOYEES)).to eq(17)
    end

    it 'given data where the header is longest, uses the header length' do
      expect(Tabulate.max_column_width(:seperation_date, EMPLOYEES)).to eq(15)
    end
  end

  describe '#column_widths' do
    it 'returns a data structure of widths for a set of data' do
      expect(Tabulate.column_widths(EMPLOYEES)).to eq({
        name: 17,
        position: 10,
        seperation_date: 15
      })
    end
  end

  describe '#puts_header' do
    it 'prints the correct header' do
      expected = <<~OUTPUT
Name              | Position   | Seperation Date
OUTPUT
      headers = Tabulate.get_headers(EMPLOYEES)
      widths = Tabulate.column_widths(EMPLOYEES)

      expect { Tabulate.puts_header(headers, widths) }.to output(expected).to_stdout
    end
  end

  describe '#puts_hr' do
    it 'prints a horizontal rule of the right length' do
      expected = '-' * 49 + "\n"
      widths = Tabulate.column_widths(EMPLOYEES)

      expect { Tabulate.puts_hr(widths) }.to output(expected).to_stdout
    end
  end

  describe '#puts_row' do
    it 'given a data row, the headers and widths outputs the data' do
      expected = <<~OUTPUT
Jacquelyn Jackson | DBA        |
OUTPUT
      headers = Tabulate.get_headers(EMPLOYEES)
      widths = Tabulate.column_widths(EMPLOYEES)

      expect { Tabulate.puts_row(EMPLOYEES.first, headers, widths) }.to output(expected).to_stdout
    end
  end
end
