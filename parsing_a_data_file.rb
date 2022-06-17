Employee = Struct.new(:last, :first, :salary) do
end

def employee_from_data(last, first, salary)
  Employee.new(last, first, salary.to_i)
end

def parse_line(line)
  line.chomp.split(',')
end

def employees_from_file(file)
  file.readlines.map { |line| employee_from_data(*parse_line(line)) }
end

# Output part of challenge is well covered by Tabulate class and is trivial to write
