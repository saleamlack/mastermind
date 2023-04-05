# frozen_string_literal: true

require_relative 'board'
require_relative 'game'
require_relative 'mastermind'
require_relative 'player'

# Create instance of new game and includes method to start the game
class PlayMastermind
  include Mastermind
  include InstructionAndText

  def play
    game = Game.new(HumanPlayer.new, ComputerPlayer.new)
    board = Board.new
    game.start_game(board)
  rescue Interrupt
    puts "\nExiting the game..."
    exit(1)
  end
end

new_game = PlayMastermind.new
new_game.welcome
new_game.play
