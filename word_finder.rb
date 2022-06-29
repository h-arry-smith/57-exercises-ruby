class WordFinder
  attr_accessor :words

  def initialize
    @words = {}
  end

  def <<((bad_word, good_word))
    @words[bad_word] = good_word
  end

  def load_config(file_path)
    file = File.open(file_path)

    file.each_line { |line| self << line.chomp.split(' ') }

    file.close
  end

  def replace_file(input_file, output_file)
    input = File.open(input_file)
    output = File.open(output_file)

    metadata = {}

    input.each_line do |line|
      words = line.split(' ')

      words.map! do |word|
        @words.each_pair do |bad_word, good_word|
          if word.match? bad_word
            metadata[bad_word] = 1 if metadata[bad_word].nil?
            metadata[bad_word] += 1

            word.gsub!(bad_word, good_word)
          end
        end

        word
      end

      output.write(words.join(' ') + "\n")
    end

    input.close
    output.close

    metadata
  end
end
