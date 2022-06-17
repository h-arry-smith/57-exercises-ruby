require 'date'
require_relative '../sorting_records'

EMPLOYEES = [
  Employee.new('John Johnson', 'Manager', Date.parse('2016-12-31')),
  Employee.new('Tou Xiong', 'Software Engineer', Date.parse('2016-10-15')),
  Employee.new('Michaela Michaelson', 'District Manager', Date.parse('2015-12-19')),
  Employee.new('Jake Jacobson', 'Programmer', nil),
  Employee.new('Jacquelyn Jackson', 'DBA', nil),
  Employee.new('Sally Weber', 'Web Developer', nil)
]


RSpec.describe '#sort_by' do
  it 'given the name header, sorts a list of structs in alphabetical order' do
    expected = [
      Employee.new('Jacquelyn Jackson', 'DBA', nil),
      Employee.new('Jake Jacobson', 'Programmer', nil),
      Employee.new('John Johnson', 'Manager', Date.parse('2016-12-31')),
      Employee.new('Michaela Michaelson', 'District Manager', Date.parse('2015-12-19')),
      Employee.new('Sally Weber', 'Web Developer', nil),
      Employee.new('Tou Xiong', 'Software Engineer', Date.parse('2016-10-15'))
    ]

    expect(sort_by(EMPLOYEES, :name)).to eq(expected)
  end

  it 'given the position header, sorts a list of structs in alphabetical order' do
    expected = [
      Employee.new('Jacquelyn Jackson', 'DBA', nil),
      Employee.new('Michaela Michaelson', 'District Manager', Date.parse('2015-12-19')),
      Employee.new('John Johnson', 'Manager', Date.parse('2016-12-31')),
      Employee.new('Jake Jacobson', 'Programmer', nil),
      Employee.new('Tou Xiong', 'Software Engineer', Date.parse('2016-10-15')),
      Employee.new('Sally Weber', 'Web Developer', nil)
    ]

    expect(sort_by(EMPLOYEES, :position)).to eq(expected)
  end

  it 'given the seperation date header, sorts a list of structs in order of its date' do
    expected = [
      Employee.new('Michaela Michaelson', 'District Manager', Date.parse('2015-12-19')),
      Employee.new('Tou Xiong', 'Software Engineer', Date.parse('2016-10-15')),
      Employee.new('John Johnson', 'Manager', Date.parse('2016-12-31')),
      Employee.new('Jake Jacobson', 'Programmer', nil),
      Employee.new('Jacquelyn Jackson', 'DBA', nil),
      Employee.new('Sally Weber', 'Web Developer', nil)
    ]

    expect(sort_by(EMPLOYEES, :seperation_date)).to eq(expected)
  end
end
