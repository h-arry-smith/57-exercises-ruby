def gets_n_numbers(n)
  numbers = []
  numbers << gets_i while numbers.length < n
  numbers
end

def gets_i(prompt = '')
  puts prompt
  input = ''

  input = gets.chomp until input.match?(/\d+/)

  input.to_i
end

def sum_user_total
  gets_n_numbers(gets_i).sum
end
