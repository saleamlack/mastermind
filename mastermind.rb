# frozen_string_literal: true

# provides modules and methods for the game
module Mastermind
  # provides constants for playing the game
  module MastermindConfig
    CODE_ICON = { 'solid' => "\u25cf", 'hollow' => "\u25cb", 'key_solid' => "\u25aa", 'key_hollow' => "\u25ab" }.freeze
    MAX_TURN = 12
    COLOR_CODES = %w[1 2 3 4 5 6].freeze
    SOLUTION_CODES = (1111..6666).to_a.select do |solution|
      solution.to_s.split('').all? { |code| COLOR_CODES.include?(code) }
    end
  end
end
