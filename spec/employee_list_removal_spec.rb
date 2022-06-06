require 'stringio'
require_relative '../employee_list_removal'

EMPLOYEES = [
  'Harry Smith',
  'Jake Saunders',
  'Oisin Clarke'
]

RSpec.describe EmployeeList do
  describe 'loading from files' do
    it 'loads employee names from a file' do
      employee_list = EmployeeList.new(employee_file)

      expect(employee_list.employees).to eq(EMPLOYEES)
    end
  end

  describe 'removing an employee' do
    it 'removes an employee from the list' do
      employee_list = EmployeeList.new(employee_file)

      employee_list.remove('Oisin Clarke')

      expect(employee_list.employees).to eq(['Harry Smith', 'Jake Saunders'])
    end

    it 'raises error if employee is not in the list' do
      employee_list = EmployeeList.new(employee_file)

      expect { employee_list.remove('Not In List') }.to raise_exception(NotFoundError)
    end
  end

  describe 'saving employees to a file' do
    it 'saves the list to a given file object' do
      employee_list = EmployeeList.new(employee_file)
      new_file = StringIO.new

      employee_list.remove('Oisin Clarke')
      employee_list.save(new_file)

      expect(new_file.string).to eq("Harry Smith\nJake Saunders\n")
    end
  end
end

def employee_file
  file = StringIO.new
  EMPLOYEES.each { |employee| file.puts employee }
  file
end
