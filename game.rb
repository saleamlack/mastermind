# frozen_string_literal: true

require_relative 'mastermind'
require_relative 'board'

# provides methods for running the game, setting up codemaker and
# codebreaker, checking if the game is over
class Game
  include Mastermind
  include MastermindConfig
  include CountPegs
  include InstructionAndText
  include Validator

  attr_accessor :turn, :turn_guess, :codemaker, :codebreaker, :human_player
  attr_reader :secret_code

  def initialize(human_player, computer_player)
    self.human_player = human_player
    self.turn = 1
    self.turn_guess = nil
    self.codemaker = code_maker(human_player, computer_player)
    self.codebreaker = code_breaker(human_player, computer_player)
    @secret_code = nil
  end

  def start_game(board)
    setup_code(board)
    initialize_turn(board)
    end_game(board)
  end

  private

  def setup_code(board)
    board.draw_board(turn)
    @secret_code = codemaker.make_code
  end

  def initialize_turn(board)
    loop do
      break if turn > MAX_TURN || broken?(turn_guess)

      self.turn_guess =
        if human_player.code_maker
          codebreaker.guess_code(secret_code)
        else
          codebreaker.guess_code
        end
      feedback = give_feedback(turn_guess, secret_code)
      board.get_played_codes(turn_guess, feedback)
      board.draw_board(turn)
      self.turn += 1
    end
  end

  def end_game(board)
    board.draw_board(turn - 1, secret_code)
    display_message
    play_or_exit == 'y' ? play_again : quit_game
  end

  def code_maker(human_player, computer_player)
    selected_option = play_as_codemaker_codebreaker
    if selected_option.to_i == 1
      human_player.code_maker = true
      human_player
    else
      computer_player
    end
  end

  def code_breaker(human_player, computer_player)
    human_player.code_maker ? computer_player : human_player
  end

  def play_as_codemaker_codebreaker
    puts "\nWould you like to play as\n\t1. Codemaker or\n\t2. Codebreaker"
    print 'Selection: '
    selected_option = gets.chomp
    if valid_player?(selected_option)
      selected_option
    else
      puts "\e[31mIncorrect input! Please enter 1 or 2.\e[0m"
      play_as_codemaker_codebreaker
    end
  end

  def broken?(turn_guess)
    secret_code == turn_guess
  end

  def give_feedback(guess_code, secret_code)
    white_pegs, red_pegs = count_key_pegs(guess_code, secret_code)
    guess_code.map do
      if red_pegs.positive?
        red_pegs -= 1
        '2'
      elsif white_pegs.positive?
        white_pegs -= 1
        '1'
      end
    end
  end

  def display_message
    if broken?(turn_guess) && human_player.code_maker
      lose_message(human_player)
    elsif broken?(turn_guess)
      win_message(human_player)
    else
      lose_message(human_player)
    end
    puts 'Thank you!'
  end

  def play_again
    system('clear') || system('cls')
    PlayMastermind.new.play
  end

  def quit_game
    exit(0)
  end
end
