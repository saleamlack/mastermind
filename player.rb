# frozen_string_literal: true

require_relative 'mastermind'

# A class to define behaviors of human player
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

# define behavior of computer player
class ComputerPlayer
  def make_code
    (1111..6666).to_a.sample
  end
end
