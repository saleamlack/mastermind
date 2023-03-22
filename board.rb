# frozen_string_literal: true

# A class to draw, read, write the board
class Board
  attr_accessor :secret_code, :code_holes, :key_holes, :turn

  def initialize
    self.secret_code = Array.new(4)
    self.code_holes = Array.new(12) { Array.new(4) }
    self.key_holes = Array.new(12) { Array.new(4) }
    self.guess_turn = 1
    self.shield = 'SHIELD'
  end
end
