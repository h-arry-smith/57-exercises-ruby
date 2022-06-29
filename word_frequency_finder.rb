def count_words(file)
  word_counts = {}

  file.each_line do |line|
    line.split(' ').each do |word|
      if word_counts[word]
        word_counts[word] += 1
      else
        word_counts[word] = 1
      end
    end
  end

  word_counts
end

def show_word_frequencies(data)
  sorted_data = data.sort_by { |_k, v| -v }.to_h
  padding = 0

  sorted_data.each_key { |key| padding = key.length if key.length > padding }
  padding += 2

  sorted_data.each_pair do |word, frequency|
    title = "#{word}:".ljust(padding, ' ')

    puts "#{title}#{'*' * frequency}"
  end
end
