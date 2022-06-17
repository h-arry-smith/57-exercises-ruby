def numbers_to_array(string, delim = ' ')
  string.strip.split(delim).map(&:to_i)
end

def filter_even_numbers(array)
  new = []

  array.each { |el| new << el if el.odd? }

  new
end

def file_to_array(file)
  new = []
  file.each_line { |line| new << line.strip.to_i }
  new
end
