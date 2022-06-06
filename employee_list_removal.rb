class EmployeeList
  attr_reader :employees

  def initialize(file)
    @employees = load_from_file(file)
  end

  def remove(employee)
    raise NotFoundError unless employees.include? employee

    @employees.delete(employee)
  end

  def save(file)
    @employees.each { |employee| file.puts employee }
  end

  private

  def load_from_file(file)
    file.seek(0)
    file.readlines(chomp: true)
  end
end

class NotFoundError < StandardError
end
