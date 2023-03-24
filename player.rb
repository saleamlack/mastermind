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

# A class to define behaviors of human player
class HumanPlayer < Player
  def make_code
    prompt_message
    secret_code = gets.chomp.split(' ')
  end

  private

  def prompt_message
    puts 'Please enter your guess using numbers of each color.' unless self.code_maker
    puts 'Please enter your secret code using numbers of each color.' if self.code_maker
    puts 'Note: the numbers must be'
    puts " - \e[31mIn correct oreder \e[37m(left-right)\e[0m\e[0m"
    puts " - \e[31mSeparated by spaces.\e[37m(ex. 1 2 3 4)\e[0m\e[0m"
  end
end
