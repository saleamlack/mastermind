# frozen_string_literal: true

# Game: define required methods for the game
class Game
  attr_accessor :player1, :player2, :game_round

  def initialize(player1_obj, player2_obj)
    self.player1 = player1_obj
    self.player2 = player2_obj
    self.board = Board.new
    self.game_round = 1
    self.codemaker = nil
    self.codebreaker = nil
  end

  def code_maker
    puts "Who make the code?
    1. #{player1.name}
    2. #{player2.name}"
    self.codemaker, self.codebreaker =
      if gets.chomp.to_i == 1
        [player1, player2]
      else
        [player2, player1]
      end
    codemaker.code_maker = true
  end

  def switch_codemaker
    codemaker.code_maker = false
    temp = codemaker
    self.codemaker = codebreaker
    self.codebreaker = temp
    codemaker.code_maker = true
  end
end
