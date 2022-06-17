# NB: Tabulated data output is required in several challenges of this book and has been
# abstracted to it's own class, with tests, to save duplication of this code.
# Individual challenges will now focus on the core of the challenge, and not focus on
# any of the output formatting concerns.
Employee = Struct.new(:name, :position, :seperation_date) do
end

def sort_by(array, field)
  array.sort_by { |el| [el[field] ? 0 : 1, el[field]] }
end
