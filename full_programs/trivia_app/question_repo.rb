require 'rom-repository'
require_relative 'question'

class QuestionRepo < ROM::Repository[:questions]
  struct_namespace Entities
  commands :create

  def all_questions_of_difficulty(difficulty)
    questions.where(difficulty: difficulty).to_a
  end
end
