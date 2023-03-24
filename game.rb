# frozen_string_literal: true

# Game: define required methods for the game
class Game
  attr_accessor :player1, :player2, :game_round

  def initialize(player1_obj, player2_obj)
    self.player1 = player1_obj
    self.player2 = player2_obj
    self.game_round = 1
    self.codemaker = nil
    self.codebreaker = nil
  end

  def code_maker
    puts 'Who make the code?'
    puts "\t1. #{player1.name}"
    puts "\t2. #{player2.name}"
    if gets.chomp.to_i == 1
      player1.code_maker = true
    else
      player2.code_maker = true
    end
  end
end
