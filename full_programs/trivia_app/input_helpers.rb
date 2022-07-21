def get_valid_option(options)
  answer = ''
  answer = get_input('>').downcase until options.include? answer
  answer
end

def get_input(prompt)
  print "#{prompt} "
  gets.chomp.strip
end
