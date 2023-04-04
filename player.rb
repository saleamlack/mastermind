# frozen_string_literal: true

# A class to define behaviors of human player
class HumanPlayer
  def make_code
    prompt_message
    secret_code = gets.chomp.split
  end

  def guess_code
    prompt_message
    guess_code = gets.chomp.split
  end
end

# define behavior of computer player
class ComputerPlayer
  def make_code
    (1111..6666).to_a.sample
  end
end
