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
