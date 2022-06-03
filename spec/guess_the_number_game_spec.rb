require_relative '../guess_the_number_game'

RSpec.describe GuessingGame do
  describe 'difficulty levels' do
    it 'a difficulty level of 1 generates a random number between 1 and 10' do
      game = GuessingGame.new
      game.difficulty = 1

      expect(game.target).to be_between(1, 10)
    end

    it 'a difficulty level of 2 generates a random number between 1 and 100' do
      game = GuessingGame.new
      game.difficulty = 2

      expect(game.target).to be_between(1, 100)
    end

    it 'a difficulty level of 3 generates a random number between 1 and 100' do
      game = GuessingGame.new
      game.difficulty = 3

      expect(game.target).to be_between(1, 1000)
    end

    it 'changing difficulty changes the target number' do
      game = GuessingGame.new
      game.difficulty = 1
      old_target = game.target
      game.difficulty = 2

      expect(game.target).not_to eq(old_target)
    end
  end

  describe 'guesing numbers' do
    it 'guessing a number too low returns too low and increases guess by 1' do
      game = GuessingGame.new
      game.difficulty = 2
      game.instance_variable_set(:@target, 50)

      expect(game.guesses).to eq(0)
      expect(game.guess(25)).to eq([:low, 1])
      expect(game.guesses).to eq(1)
    end

    it 'guessing a number too high returns too high and increases guess by 1' do
      game = GuessingGame.new
      game.difficulty = 2
      game.instance_variable_set(:@target, 50)

      expect(game.guesses).to eq(0)
      expect(game.guess(75)).to eq([:high, 1])
      expect(game.guesses).to eq(1)
    end

    it 'after multiple guesses, the right answer is given and guesses are reset, and the target is changed' do
      game = GuessingGame.new
      game.difficulty = 2
      game.instance_variable_set(:@target, 50)
      old_target = game.target

      expect(game.guesses).to eq(0)
      expect(game.guess(25)).to eq([:low, 1])
      expect(game.guess(75)).to eq([:high, 2])
      expect(game.guesses).to eq(2)

      expect(game.guess(50)).to eq([:right, 3])
      expect(game.guesses).to eq(0)
      expect(game.target).not_to eq(old_target)
    end

    it 'a non numeric guess increases guesses and returns wrong' do
      game = GuessingGame.new
      game.difficulty = 2

      expect(game.guess('abcd')).to eq(:wrong)
      expect(game.guesses).to eq(1)

      expect(game.guess(:hello)).to eq(:wrong)
      expect(game.guesses).to eq(2)
    end
  end

  describe 'win messages' do
    it 'with differing numbers of guesses returns a winners text' do
      game = GuessingGame.new

      expect(game.winner_text(1)).to eq("You're a mind reader.")
      expect(game.winner_text(2)).to eq('Most impressive.')
      expect(game.winner_text(5)).to eq('You can do better than that.')
      expect(game.winner_text(8)).to eq('Better luck next time.')
    end
  end
end
