# frozen_string_literal: true

# this just holds cell information. both for lines and for scorekeeping cells.
class Cell
  attr_accessor :color

  def initialize
    @color = 'o'
  end
end

# this will be for each row of gameplay.
class Row
  attr_accessor :row

  def initialize
    @row = [Cell.new, Cell.new, Cell.new, Cell.new]
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
  attr_accessor :total, :board

  def initialize
    @total = 0
    @board = []
    30.times do
      @board.push('o')
    end
  end
end

# the Board
class Board
  attr_accessor :board, :shield_row, :rows, :key_rows, :player1_score, :player2_score, :scoreboard

  def initialize
    @board = board
    @shield_row = ShieldRow.new
    @rows = []
    @key_rows = []
    12.times do
      @rows.push(Row.new)
      @key_rows.push(KeyRow.new)
    end
    @player1_score = Score.new
    @player2_score = Score.new
    @scoreboard = []
  end

  def fill_scoreboard
    30.times { |i| 
      @scoreboard.push([@player1_score.board[i], @player2_score.board[i]])
      i += 1
    }
  end

  # allows to access the row of colors. not sure how to use this just yet.
  # def row_colors(i)
  #   p @rows[i].row[0].color
  #   p @rows[i].row[1].color
  #   p @rows[i].row[2].color
  #   p @rows[i].row[3].color
  # end

  # def view_current
  #   puts @board[11]
  # end
end

# player class. contains players regardless of human or computer.
class Player
  def initialize(name)
    @name = name
  end
end

class HumanPlayer < Player
end

# just for computer opponent.
class ComputerPlayer < Player
  def initialize
    @name = 'Larry'
    puts "Hi, my name is Larry."
  end

  def choose_colors
  end
end

# the game
class Game
  def initialize
    @board = Board.new
    make_players
  end

  def make_players
    make_human_player(@player1)
    make_player2
  end

  # ask human for name, set name
  def make_human_player(player)
    puts 'Player, what is your name?'
    player = HumanPlayer.new(gets.chomp)
  end

  def make_player2
    puts 'Is this player human or computer?'
    answer = gets.chomp
    if answer.downcase == 'human'
      make_human_player(@player2)
    elsif answer.downcase == 'computer'
      @player2 = ComputerPlayer.new
    else
      puts 'Sorry, please try again.'
      make_player2
    end
  end

  def play
    # fuck you rubocop
  end
end

my_game = Game.new
my_game.play