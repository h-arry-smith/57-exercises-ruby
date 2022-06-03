def multiples_row(x, n)
  (0..x).map { |y| y * n }
end

def multiples_table(x)
  (0..x).map { |y| multiples_row(x, y) }
end

def print_table(n)
  multiples_table(n).each do |row|
    s = ''
    row.each do |number|
      s << number.to_s.rjust(4, ' ')
    end
    puts s
  end
end
