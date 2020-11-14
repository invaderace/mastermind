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
    @legend_contents = 'Hi. Welcome to mastermind.'
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
    display_shield_row
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

  def display_shield_row
    puts "|| #{@shield_row.join '  '} ||".center(line_width)
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
  attr_accessor :code, :guess, :name, :score

  def initialize
    @code = code
    @guess = guess
    @name = name
    @score = 0
  end

  def code_input
    @code = gets.chomp.split('')
  end
end

# duh.
class ComputerPlayer
  attr_accessor :code, :guess, :name, :score

  def initialize
    @code = code
    @guess = guess
    @name = 'Computer'
    @score = 0
  end

  def code_input
    @code = rand(6667).to_s.split('')
  end
end

# All gameplay related things get made and stored here (players, board)
class Game
  attr_accessor :player1, :player2, :board

  def initialize
    @player1 = HumanPlayer.new
    # @player2
    @board = Board.new
  end

  # explain the rules.
  # defintro
  # end

  # add methods to choose players. ie Human or Computer? Get names. etc.

  def play
    @board.display
    set_player1
    set_player2
    # tell(rules)
    secret_code
    # take turns
  end

  def set_player1
    @player1.name = player_name
    hello(@player1)
  end

  def set_player2
    if player_type == 'human'
      @player2 = HumanPlayer.new
      @player2.name = player_name
      hello(@player2)
    else
      @player2 = ComputerPlayer.new
      introduce(@player2)
    end
  end

  def tell(things)
    things.each { |thing|
      @board.legend_contents = thing if gets.chomp
      @board.display
    }
  end

  def player_name
    tell(ask_name)
    answer = gets.chomp
    if answer != ''
      answer
    else
      tell(sorry)
      player_name if gets.chomp
    end
  end

  def player_type
    tell(ask_human_or_computer)
    answer = gets.chomp
    if answer.downcase == 'human' || answer.downcase == 'computer'
      answer
    else
      tell(sorry)
      player_type
    end
  end

  def secret_code
    tell(ask_code)
    @player2.code_input
    #input code
  end

  def hello(player)
    @board.legend_contents = "Hi #{player.name}."
    @board.display
  end

  def introduce(player)
    @board.legend_contents = "This is #{player.name}."
    @board.display
  end

  def ask_code 
    [
      'The codemaster needs to input a secret code.',
      'Codemaster, enter your code please.'
    ]
  end

  def ask_human_or_computer
    ['Is this player human or computer?']
  end

  def ask_name
    ['What is your name?']
  end

  def rules
    [
      'First, the codemaker will create a four digit code.',
      'The codebreaker will try to guess in 12 turns.',
      'For each guess, the key on the right  will show the result.',
      'For each correct digit in the correct spot it will show "O".',
      'For each correct digit out of place it will show "o".',
      'For each incorrect digit you will get 30 lashes.',
      "......just seeing if you're paying attention still.",
      'Incorrect digits get nothing.'
    ]
  end

  def sorry
    ['Sorry, please try that again.']
  end
end

my_game = Game.new
my_game.play
p my_game.player2.code
