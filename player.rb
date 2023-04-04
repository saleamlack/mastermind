# frozen_string_literal: true

require_relative 'mastermind'

# reprensts a human player in the game
# include methods for making and guessing codes, as well as
# validate each inputs
class HumanPlayer
  include Mastermind
  include InstructionAndText
  include Validator

  def make_code
    puts "\nPlease create secret code."
    print "\e[34mSecret code\e[0m: "
    code = gets.chomp.split('')
    test_code(code, method(:make_code))
  end

  def guess_code
    puts 'Please enter your guess code.'
    print "\e[34mGuess code\e[0m: "
    code = gets.chomp.split('')
    test_code(code, method(:guess_code))
  end

  private

  def test_code(code, action)
    if valid_code?(code)
      code
    else
      invalid_code
      action.call
    end
  end
end

# represents a computer player in the game
# include methods for making and guessing codes, as well as evaluating guesses
class ComputerPlayer
  include Mastermind
  include MastermindConfig
  include CountPegs

  attr_accessor :best_score, :new_solutions, :last_guess

  def initialize
    self.last_guess = nil
    self.best_score = -1
    self.new_solutions = SOLUTION_CODES
  end

  def make_code
    new_solutions.sample.to_s.split('')
  end

  def guess_code(secret_code)
    sleep(1)
    return generate_guess(secret_code) if best_score == -1

    self.new_solutions = new_solutions.select do |code|
      guess = code.to_s.split('')
      score = evaluate(last_guess, guess)
      score == best_score
    end
    generate_guess(secret_code)
  end

  private

  def generate_guess(secret_code)
    self.last_guess = make_code
    self.best_score = evaluate(last_guess, secret_code)
    last_guess
  end

  def evaluate(guess, secret_code)
    white_pegs, red_pegs = count_key_pegs(guess, secret_code)
    white_pegs + red_pegs * 2
  end
end
