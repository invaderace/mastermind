# frozen_string_literal: true

# game board should setup the board elements and be able to display.
# each row will be an array. I'm thinking shield row and decode rows will be
# the same row function. decode rows probably can be stored in a hash for easy
# access.
class Board
  attr_accessor :shield_row, :decoding_rows, :key_rows, :line_width, :legend_contents

  def initialize
    @shield_row = make_shield_row
    @decoding_rows = make_decoding_or_key_rows
    @key_rows = make_decoding_or_key_rows
    @legend_contents = legend_contents
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
    puts " #{legend_contents} ".center(line_width)
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
  attr_accessor :player1, :player2, :board

  def initialize
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  # explain the rules.
  # defintro
  # end

  # add methods to choose players. ie Human or Computer? Get names. etc.

  def play
    explain_rules
  end

  def explain_rules
    @board.legend_contents = "Hi. Let's play mastermind."
    @board.display
    if enter?
      @board.legend_contents = 'Are you ready?'
    end
    @board.display
  end

  def enter?
    false
    true if gets.chomp == ''
  end
end

my_game = Game.new
my_game.play

