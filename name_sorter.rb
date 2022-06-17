def sort_file(in_file, out_file)
  names = []

  in_file.each_line { |line| names << line.chomp.strip }

  out_file.puts "Total of #{names.length} names"
  out_file.puts "-" * 20
  names.sort.each { |name| out_file.puts name }
end
