require 'rom'

module Entities
  class Question < ROM::Struct
    attr_reader :randomised_ordered_answers

    def initialize(attributes)
      @attributes = attributes

      super
      @randomised_ordered_answers = random_ordered_answer_hash
    end

    def print_question
      puts "Category #{category} | Difficulty: #{difficulty_text}"
      puts '-' * 60
      puts "Q: #{question}"
      puts ''
      puts_answers
      puts ''
    end

    def correct_guess?(guess)
      guess == correct_guess_key
    end

    private

    def correct_guess_key
      @randomised_ordered_answers.key(answer)
    end

    def answers
      [answer, wrong_answer_one, wrong_answer_two]
    end

    def puts_answers
      @randomised_ordered_answers.each_pair { |key, text| puts "#{key}) #{text}" }
    end

    def random_ordered_answer_hash
      keys = %w[a b c]
      hash = {}

      answers.shuffle.each_with_index { |answer, index| hash[keys[index]] = answer }

      hash
    end

    def difficulty_text
      case difficulty
      when 1
        'Easy'
      when 2
        'Medium'
      when 3
        'Hard'
      end
    end
  end
end
