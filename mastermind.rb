# frozen_string_literal: true

# game board should setup the board elements and be able to display.
# each row will be an array. I'm thinking shield row and decode rows will be
# the same row function. decode rows probably can be stored in a hash for easy
# access.
class Board
  attr_accessor :shield_row, :decoding_rows, :key_rows

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
    decoding_rows = {}
    i = 0
    decoding_rows[i += 1] = make_row until i == 12
    decoding_rows
  end
end

my_board = Board.new
puts my_board
