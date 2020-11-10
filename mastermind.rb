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

  # let's work on displaying the board.
  def display
    system 'clear'
    @line_width = 60
    display_header
    display_board
  end

  def display_header
    4.times{puts}
    puts "Mastermind".center(line_width)
    2.times{puts}
  end

  def display_board
    i = 12
    while i > 0
      puts "\#\#\#\# || #{@decoding_rows[i].join '  '} || #{@key_rows[i].join}".center(line_width)
      i -= 1
    end
    2.times{puts}
  end
end

my_board = Board.new
my_board.display
