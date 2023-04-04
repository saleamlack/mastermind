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

    # provides a method for counting the number of red and white pegs
  module CountPegs
    def count_key_pegs(guess_code, secret_code)
      white_pegs = 0
      red_pegs = 0
      secret_counts = secret_count_peg(secret_code)
      guess_code.each_with_index do |peg, i|
        red_pegs += 1 if peg == secret_code[i]
        if secret_counts[peg].positive?
          white_pegs += 1
          secret_counts[peg] -= 1
        end
      end
      [white_pegs -= red_pegs, red_pegs]
    end

    private

    def secret_count_peg(secret_code)
      secret_code.each_with_object(Hash.new(0)) do |peg, counts|
        counts[peg] += 1
      end
    end
  end
end
