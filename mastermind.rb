# frozen_string_literal: true

# This module only holds text to be told to players.
module Instructable
  def tell(things)
    tell_string(things) if things.class == String
    tell_array(things) if things.class == Array
  end

  def tell_array(things)
    things.each do |thing|
      @board.legend_contents = thing if gets.chomp
      @board.display
    end
  end

  def tell_string(things)
    @board.legend_contents = things
    @board.display
  end

  def ask_code
    [
      'The codemaster needs to input a secret code.',
      'Codemaster, enter your code please.'
    ]
  end

  def ask_codebreaker_or_codemaster
    'Will you be the codebreaker or codemaster?'
  end

  def ask_human_or_computer
    'Is this player human or computer?'
  end

  def ask_name
    'What is your name?'
  end

  def enter_guess
    'Codebreaker, enter your guess please.'
  end

  def round_winner
    'The Codebreaker solved this round!'
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
    'Sorry, please try that again.'
  end
end

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

  def hide_code
    @shield_row = ['?', '?', '?', '?']
  end

  def show_code(input)
    @shield_row = input
  end
end

# both player types setup.
class Player
  attr_accessor :code, :guess, :name, :result, :score

  def initialize
    @code = []
    @guess = guess
    @name = name
    @score = 0
  end
end

# duh.
class HumanPlayer < Player
  def code_input
    @code = gets.chomp.split('')
  end

  def guess_input
    @guess = gets.chomp.split('')
  end
end

# duh.
class ComputerPlayer < Player
  def name
    @name = 'Computer'
  end

  def code_input
    4.times { @code.push(rand(1..6).to_s) }
  end
end

# All gameplay related things get made and stored here (players, board)
class Game
  include Instructable

  attr_accessor :board, :player1, :player2, :result

  def initialize
    @board = Board.new
    @code_placeholder = []
    @guess_placeholder = []
    @player1 = HumanPlayer.new
    @result = []
  end

  def play
    @board.display
    set_player1 if gets.chomp
    set_player2 if gets.chomp
    # tell(rules)
    set_player_roles
    secret_code
    guesses
  end

  def guesses
    i = 1
    until round_win?
      tell(enter_guess)
      @codebreaker.guess_input
      while @codebreaker.guess.length != 4
        tell(sorry)
        @codebreaker.guess_input
      end
      @board.decoding_rows[i] = @codebreaker.guess
      @board.key_rows[i] = check_guess
      @board.display
      i += 1
    end
    @board.show_code(@codemaster.code)
    tell(round_winner)
  end

  # should output an array of guess results.
  def check_guess
    reset_guess
    check_number_and_position
    check_number_only
    fill_result
    @result
  end
  
  def codebreaker_or_codemaster
    tell(ask_codebreaker_or_codemaster)
    answer = gets.chomp
    if answer.downcase == 'codebreaker' || answer.downcase == 'codemaster'
      answer
    else
      tell(sorry)
      codebreaker_or_codemaster
    end
  end

  def reset_guess
    @result = []
    @guess_placeholder = [].concat(@player1.guess)
    @code_placeholder = [].concat(@player2.code)
  end

  def check_number_and_position
    i = 3
    while i >= 0
      if @guess_placeholder[i] == @code_placeholder[i]
        @result.push('●')
        @guess_placeholder.delete_at(i)
        @code_placeholder.delete_at(i)
      end
      i -= 1
    end
  end

  def check_number_only
    @guess_placeholder.each do |i|
      if @code_placeholder.include?(i)
        @result.push('◯')
        @code_placeholder.delete_at(@code_placeholder.index(i))
      end
    end
  end

  def fill_result
    @result.push('_') while @result.length < 4
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
    @codemaster.code_input
    while @codemaster.code.length != 4
      tell(sorry)
      @codemaster.code_input
    end
    @board.hide_code
  end

  def set_player1
    @player1.name = player_name
    hello(@player1)
  end

  def set_player2
    if player_type == 'human'
      @player2 = HumanPlayer.new
      @player2.name = player_name    ########## it pauses here because it needs gets.chomp
      hello(@player2)
    else
      @player2 = ComputerPlayer.new
      @player2.name
      introduce(@player2)
    end
  end

  def set_player_roles
    if codebreaker_or_codemaster == 'codebreaker'
      @codebreaker = @player1
      @codemaster = @player2
    else
      @codebreaker = @player2
      @codemaster = @player1
    end
  end

  def swap_roles
    #code to swap roles goes here.
  end

  def round_win?
    true if @result == ['●', '●', '●', '●']
  end

  def hello(player)
    @board.legend_contents = "Hi #{player.name}."
    @board.display
  end

  def introduce(player)
    @board.legend_contents = "This is #{player.name}."
    @board.display
  end
end

my_game = Game.new
my_game.play
