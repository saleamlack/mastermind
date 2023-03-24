# frozen_string_literal: true

# A class to track state of players
class Player
  attr_accessor :name, :score, :code_maker
  def initialize(name)
    self.name = name
    self.score = 0
    self.code_maker = false
  end
end
