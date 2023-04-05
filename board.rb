# frozen_string_literal: true

require_relative 'mastermind'

# A class to draw, read, write the board
class Board
  include Mastermind
  include MastermindConfig

  attr_accessor :guess_codes, :feedback_keys

  def initialize
    self.guess_codes = []
    self.feedback_keys = []
  end

  # Add each turn guess and feedback to their respective array
  def get_played_codes(guess_code, feedback_key)
    guess_codes.unshift(guess_code)
    feedback_keys.unshift(feedback_key)
  end

  def draw_board(turn, shield = 'SHIELD')
    print_head(shield)
    print_pegs(turn)
    print_code_container
  end

  private

  # print componets of the head of the board (shield, feed, and turn)
  def print_head(shield)
    puts "\n==========================================="
    print '['
    if shield == 'SHIELD'
      print " \e[37;1;40m  #{shield}  \e[0m "
    else
      print_guess('solid', shield)
    end
    print "][ \e[44m   FEED   \e[0m"
    puts  " ][ \e[44m    TURN   \e[0m ]"
    puts '-------------------------------------------'
  end

  # print played code pegs, feedback keys, and turn
  def print_pegs(turn)
    guess_codes.each_with_index do |codes, index|
      print '['
      print_guess('solid', codes)
      print ']['
      sort_keys = feedback_keys[index].sort { |a, b| b.to_i - a.to_i }
      print_feedback(codes, sort_keys)
      print ']['
      puts "\t   #{turn - index}\t  ]"
    end
  end

  # print all available colors
  def print_code_container
    puts "\e[40m===========================================\e[0m"
    print_guess('solid', COLOR_CODES, container: true)
    puts "\n\e[40m-------------------------------------------\e[0m"
  end

  def print_guess(icon, guess_code, container: false)
    guess_code.each do |color_code|
      print container ? "  #{color_code}." : nil
      print " \e[3#{color_code}m#{CODE_ICON[icon]}\e[0m " unless color_code == '6'
      print " \e[3#{color_code.to_i + 1}m#{CODE_ICON[icon]}\e[0m " if color_code == '6'
      puts if container && (color_code.to_i == COLOR_CODES.size / 2)
    end
  end

  def print_feedback(guess_code, keys)
    guess_code.each_index do |j|
      case keys[j]
      when '1' then print " \e[37m#{CODE_ICON['key_solid']}\e[0m "
      when '2' then print " \e[31m#{CODE_ICON['key_solid']}\e[0m "
      else print " #{CODE_ICON['key_hollow']} "
      end
    end
  end
end
