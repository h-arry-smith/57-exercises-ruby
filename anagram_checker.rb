def anagram?(first, second)
  return false unless first.length == second.length
  return true if first == second

  first = first.split('')
  second = second.split('')

  first.each do |letter|
    second.delete_at second.index(letter) || second.length
  end

  second.empty?
end
