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

  # provides methods for displaying instructions and messages to the user
  module InstructionAndText
    def welcome
      puts "\n\e[44mWelcome to Mastermind!\e[0m"
      puts 'Mastermind game is a game for two players. One player create a secret code,'
      puts 'the other player tries to guess the code for certain number of turns.'
      puts "\n\e[34mHow to play\e[0m"
      puts "- The codemaker create a code which is a combination of four colors.\n- The codebreaker guess the code"
      puts '- the codebreaker get feedback for each guess'
      puts "\t* \e[41mRED\e[0m for correct color and positon"
      puts "\t* \e[47mWHITE\e[0m for correct color but not at the right position"
      puts "\t* nothing for incorrect colors"
    end

    def win_message(human_player)
      if human_player.code_maker
        puts "\n\e[1mGreat job!\nYou have outsmarted the computer and won the game of Mastermind\e[0m"
      else
        puts "\n\e[1mCongratulations!\nYou are a code-breaking genius! Well done!\e[0m"
      end
    end

    def lose_message(human_player)
      if human_player.code_maker
        puts "\n\e[1mOh no! The computer has cracked your code and won the game of Mastermind.\e[0m"
      else
        puts "\n\e[1mGame Over!\nSorry, you were not able to break the code this time. Better luck next time!\e[0m"
      end
    end

    def play_or_exit
      print "\e[34mDo you want to play again? (y/n)\e[0m"
      gets.chomp
    end
  end
end
