require 'stringio'
require_relative '../parsing_a_data_file'

DATA = [
  'Ling,Mai,55900',
  'Johnson,Jim,56500',
  'Jones,Aaron,46000'
]

FILE = StringIO.new
DATA.each { |line| FILE.puts line }
FILE.seek(0)

RSpec.describe '#employee_from_data' do
  it 'returns a correct struct from an array of data variables' do
    data = ['Ling', 'Mai', '55900']
    employee = employee_from_data(*data)

    expect(employee.first).to eq('Mai')
    expect(employee.last).to eq('Ling')
    expect(employee.salary).to eq(55900)
  end
end

RSpec.describe '#parse_line' do
  it 'parses a read in line and splits to an array' do
    data = "Ling,Mai,55900\n"

    expect(parse_line(data)).to eq(["Ling", "Mai", "55900"])
  end
end

RSpec.describe '#employees_from_file' do
  it 'loads employees from file and returns an array of their structs' do
    expected = [
      Employee.new('Ling', 'Mai', 55900),
      Employee.new('Johnson', 'Jim', 56500),
      Employee.new('Jones', 'Aaron', 46000)
    ]

    expect(employees_from_file(FILE)).to eq(expected)
  end
end
