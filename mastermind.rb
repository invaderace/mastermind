# frozen_string_literal: true

# this just holds cell information. both for lines and for scorekeeping cells.
class Cell
  attr_accessor :cell, :color

  def initialize(color)
    @cell = cell
    @color = color
  end
end

# this will be for each row of gameplay.
class Row
  attr_accessor :row

  def initialize(color1, color2, color3, color4)
    @row = [Cell.new(color1), Cell.new(color2), Cell.new(color3), Cell.new(color4)]
  end
end

# this is for the colored pegs used in gameplay. holds 4 pegs. 12 rows total.
class CodeRow < Row
end

# this class is the shielded row that stores the answer. only 1 row.
class ShieldRow < CodeRow
end

# this is for the red and white pegs used to show the current guess accuracy.
# each holds 4 pegs just like row. 12 rows total.
class KeyRow < Row
end

# the score - there will be two of these (white and red), with cells up to 30
class Score
end

# the Board
class Board
end

# the game
class Game
end
