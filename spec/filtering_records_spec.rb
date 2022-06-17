require 'date'
require_relative '../filtering_records'

EMPLOYEES = [
  Employee.new('John Johnson', 'Manager', Date.parse('2016-12-31')),
  Employee.new('Tou Xiong', 'Software Engineer', Date.parse('2016-10-15')),
  Employee.new('Michaela Michaelson', 'District Manager', Date.parse('2015-12-19')),
  Employee.new('Jake Jacobson', 'Programmer', nil),
  Employee.new('Jacquelyn Jackson', 'DBA', nil),
  Employee.new('Sally Weber', 'Web Developer', nil)
]

RSpec.describe '#filter_by' do
  it 'given a string field, can filter by partial string matches' do
    expected = [
      Employee.new('Jake Jacobson', 'Programmer', nil),
      Employee.new('Jacquelyn Jackson', 'DBA', nil)
    ]

    expect(filter_by(EMPLOYEES, :name, 'jac')).to eq(expected)
  end

  it 'works for the position field also' do
    expected = [
      Employee.new('John Johnson', 'Manager', Date.parse('2016-12-31')),
      Employee.new('Michaela Michaelson', 'District Manager', Date.parse('2015-12-19'))
    ]

    expect(filter_by(EMPLOYEES, :position, 'man')).to eq(expected)
  end

  it 'given a date value to filter by returns everything before that date' do
    expected = [
      Employee.new('Michaela Michaelson', 'District Manager', Date.parse('2015-12-19')),
    ]

    expect(filter_by(EMPLOYEES, :seperation_date, Date.parse('2016-06-01'))).to eq(expected)
  end
end
