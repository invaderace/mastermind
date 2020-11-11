# frozen_string_literal: true

# game board should setup the board elements and be able to display.
# each row will be an array. I'm thinking shield row and decode rows will be
# the same row function. decode rows probably can be stored in a hash for easy
# access.
class Board
  attr_accessor :shield_row, :decoding_rows, :key_rows, :line_width

  def initialize
    @shield_row = make_shield_row
    @decoding_rows = make_decoding_or_key_rows
    @key_rows = make_decoding_or_key_rows
  end

  def make_row
    Array.new(4, '_')
  end

  def make_shield_row
    make_row
  end

  # this should hold 12 key/value combos. key: 1-12. value: array of entries.
  def make_decoding_or_key_rows
    hash_of_rows = {}
    i = 0
    hash_of_rows[i += 1] = make_row until i == 12
    hash_of_rows
  end

  # display the board, split into components.
  def display
    system 'clear'
    @line_width = 60
    display_header
    display_board
    display_legend
  end

  def display_header
    4.times { puts }
    puts 'Mastermind'.center(line_width)
    2.times { puts }
  end

  def display_board
    i = 12
    while i.positive?
      puts "\#\#\#\# || #{@decoding_rows[i].join '  '} || #{@key_rows[i].join}".center(line_width)
      i -= 1
    end
    2.times { puts }
  end

  def display_legend
    puts '---------------------------------------------'.center(line_width)
    puts '-  This is where rules can go. I dunno yet. -'.center(line_width)
    puts '---------------------------------------------'.center(line_width)
    puts
  end
end

# duh.
class HumanPlayer
  attr_accessor :name, :guess, :score

  def initialize
    @name = name
    @guess = guess
    @score = 0
  end
end

# duh.
class ComputerPlayer
  attr_accessor :name, :score

  def initialize
    @name = 'Computer'
    @score = 0
  end
end

class Game
  attr_accessor

  def initialize
    @player1 = player1
    @player2 = player2
  end

  # explain the rules.
  # def intro
  # end

  def play
    
  end

end

my_board = Board.new
my_board.display
