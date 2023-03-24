# frozen_string_literal: true

# A class to draw, read, write the board
class Board
  attr_accessor :secret_code, :code_holes, :key_holes, :guess_turn, :shield

  def initialize
    self.secret_code = Array.new(4)
    self.code_holes = Array.new(12) { Array.new(4) }
    self.key_holes = Array.new(12) { Array.new(4) }
    self.guess_turn = 1
    self.shield = 'SHIELD'
  end

  def draw_board
    track_active_row
    print_score
    print_holes
    print_codes
  end

  def print_score
    puts "\e[44;1;2m         Score          \e[0m"
    puts "\e[40m Human:           00    \e[0m"
    puts "\e[40m Computer:        00    \e[0m"
    puts "\e[33;2m========================\e[0m"
  end

  def print_holes
    puts "\e[43m  \e[0m\e[44;1m #{@shield} \e[0m\e[43m    Feed    \e[0m"
    code_holes.reverse.each_with_index do |holes, i|
      comb = holes + key_holes.reverse[i]
      print "\e[44m  \e[0m\e[45; \e[0m"
      comb.each_with_index do |hole, j|
        print " #{hole || '-'}"
        print " \e[45;8m|\e[0m\e[44;8m|\e[0m" if j == 3
        puts " \e[44;8m|\e[0m " if j == 7
      end
    end
  end

  def print_codes
    puts "\e[33;1m========================\e[0m"
    6.times do |i|
      print "\e[40m   \e[0m" if [0, 3].include?(i)
      print "\e[4#{i + 2}m #{i + 1} \e[0m" if i == 5
      print "\e[4#{i + 1}m #{i + 1} \e[0m" unless i == 5
      puts "\e[40m    Turn    \e[0m" if i == 2
      puts "\e[40m     #{guess_turn}      \e[0m" if i == 5
    end
    puts "\e[33;2m========================\e[0m"
  end

  def key_pegs=(guess_code)
    red_pegs = 0
    white_pegs = 0
    count_key_pegs(guess_code, red_pegs, white_pegs)
    white_pegs -= red_pegs
    guess_code.each do
      hole_idx = first_empty_key_hole
      key_holes[guess_turn - 1][hole_idx] =
        if red_pegs.positve?
          red_pegs -= 1
          "\e[41m-\e[0m"
        elsif white_pegs.positive?
          white_pegs -= 1
          "\e[47m-\e[0m"
        end
    end
  end

  def breaked?
    secret_code == code_holes[guess_turn - 1]
  end

  def full?
    guess_turn > 12
  end

  def break_shield
    self.shield = secret_code.join(' ') if breaked? || full?
  end

  private

  def track_active_row
    code_holes[guess_turn - 1].each_index do |idx|
      code_holes[guess_turn - 1][idx] = "\e[5m0\e[0m"
    end
  end

  def first_empty_key_hole
    key_holes[guess_turn - 1].each_with_index do |hole, idx|
      break idx if hole.nil?
    end
  end

  def count_key_pegs(guess_code, red_pegs, white_pegs)
    secret_counts = {}
    guess_code.each_with_index do |peg, i|
      secret_counts[peg] = secret_code.count(peg) unless secret_counts[peg]
      next unless secret_counts[peg]

      red_pegs += 1 if peg == secret_code[i]
      if secret_counts[peg].positive?
        white_pegs += 1
        secret_counts[peg] -= 1
      end
    end
  end
end

board = Board.new
board.draw_board
