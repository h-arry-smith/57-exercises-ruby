# The implementation of the game loop and associated testing is largely academic
# and well covered in other examples from this book. The core functionality is all
# provided by the class below and would be used to operate the machinery of the game

class GuessingGame
  attr_accessor :target
  attr_reader :difficulty, :guesses

  GUESS_RESPONSE = [:right, :low, :high]

  def initialize
    @guesses = 0
  end

  def guess(guess)
    @guesses += 1

    return :wrong unless guess.is_a? Numeric

    response = GUESS_RESPONSE[@target <=> guess]
    old_guesses = @guesses

    if guess == @target
      generate_target_number(@difficulty)
      @guesses = 0
    end

    [response, old_guesses]
  end

  def difficulty=(difficulty)
    @difficulty = difficulty
    generate_target_number(@difficulty)
  end

  def winner_text(guesses)
    case guesses
    when 1
      "You're a mind reader."
    when 2..4
      'Most impressive.'
    when 5..6
      'You can do better than that.'
    else
      'Better luck next time.'
    end
  end

  private

  def generate_target_number(difficulty)
    new_target = rand(1..10**difficulty) until new_target != @target

    @target = new_target
    end
end
