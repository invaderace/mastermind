# frozen_string_literal: true

# this just holds cell information. both for lines and for scorekeeping cells.
class Cell
  attr_accessor :cell, :color

  def initialize
    @cell = cell
    @color = color
  end
end

# this will be for each row of gameplay.
class Row
  attr_accessor :row

  def initialize
    @row = [Cell.new, Cell.new, Cell.new, Cell.new]
  end
end

# this is for the colored pegs used in gameplay
class CodeRow < Row
end

# this class is the shielded row that stores the answer
class ShieldRow < CodeRow
end

# this is for the red and white pegs used to show the current guess accuracy.
class KeyRow < Row
end

# the score
class Score
end

# the Board
class Board
end
