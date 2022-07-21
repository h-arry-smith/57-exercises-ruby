require 'rom'
require_relative 'question_repo'
require_relative 'input_helpers'

VALID_OPTIONS = %w[a b c]
DIFFICULTY_FACTOR = 5

rom = ROM.container(:sql, 'sqlite://questions.db') do |conf|
  require_relative 'questions'

  conf.register_relation(Questions)
end

question_repo = QuestionRepo.new(rom)

score = 0
current_difficulty = 1

available_questions = question_repo.all_questions_of_difficulty(current_difficulty)

while available_questions.length > 0
  question = available_questions.delete(available_questions.sample)

  question.print_question

  answer = get_valid_option(VALID_OPTIONS)

  if question.correct_guess?(answer)
    score += 1
    puts 'You got it right!'
  else
    puts 'You lost!'
    break
  end

  if available_questions.empty? || score >= current_difficulty * DIFFICULTY_FACTOR
    puts 'Increasing the difficulty! Too easy for you!'
    current_difficulty += 1

    available_questions = question_repo.all_questions_of_difficulty(current_difficulty)
  end

  puts "\n\n\n"
end

puts "You finished with a score of #{score}!"
