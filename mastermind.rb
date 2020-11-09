# frozen_string_literal: true

# game board should setup the board elements and be able to display.
# each row will be an array. I'm thinking shield row and decode rows will be
# the same row function. decode rows probably can be stored in a hash for easy
# access.
class Board
  def initialize
    @shield_row = shield_row
    @decode_rows = decode_rows
    @key_rows = key_rows
  end

  def row
    []
  end

  def shield_row
    row
  end

  # this should hold 12 key/value combos. key: 1-12. value: array of entries.
  def decode_rows
    {}
  end

  def key_rows
    {}
  end
end

my_board = Board.new
puts my_board
