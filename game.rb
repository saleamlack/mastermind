# frozen_string_literal: true

# Game: define required methods for the game
class Game
  attr_accessor :player1, :player2, :game_round

  def initialize(player1_obj, player2_obj)
    self.player_1 = player1_obj
    self.player_2 = player2_obj
    self.game_round = 1
  end
end
