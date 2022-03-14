# frozen_string_literal: true

# game class
class Game
  def initialize
    @positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @round = 0
    print_welcome_message
    play_game
    puts 'Goodbye!!'
  end

  private

  # play tic tac toe
  def play_game
    setup_game
    exit_game = 'y'
    until exit_game.eql? 'n'
      play_round if exit_game.eql? 'y'
      print 'Do you want to play again? [y/n]: '
      exit_game = gets.chomp.downcase
    end
  end

  # welcome message
  def print_welcome_message
    puts "Welcome to tic tac toe!!!\nHere is the board,\n#{print_board}"
    puts 'The numbers represent which square you can choose to place your x or o'
    puts "\nx always goes first, human vs human is possible, and computer vs computer is possible\n"
    puts "\nRounds are endless unless the game is ended (type 'n' at the end of each round)\n"
    puts "How should the game be? type 'human' or 'computer' to select their symbol (x or o)\n"
  end

  # setup message
  def print_setup_message(symbol)
    "\nWho will play #{symbol}? [human/computer(case insensitive)]: "
  end

  # set game
  def setup_game
    @x_player = setup_player('x')
    @o_player = setup_player('o')
  end

  # set each player
  def setup_player(symbol)
    print print_setup_message(symbol)
    validate_player_choice(symbol)
  end

  # validates user's setup choice
  def validate_player_choice(symbol)
    player = gets.chomp.downcase
    until player.include?('human') || player.include?('computer')
      puts "#{player.capitalize} can't play tic tac toe."
      print "A #{player} isn't sentient like computers (or humans or animals), so choose again: "
      player = gets.chomp.downcase
    end
    player.eql?('human') ? HumanPlayer.new(symbol) : ComputerPlayer.new(symbol)
  end

  # print the board
  def print_board
    board = "\n +---+---+---+\n"
    @positions.each_with_index do |position, idx|
      board += " | #{position}#{" |\n +---+---+---+\n" if ((idx + 1) % 3).zero?}"
    end
    board
  end

  # play a round
  def play_round
    @positions = @positions.map.with_index { |_, idx| idx + 1 }
    @round += 1
    loop do
      return if prompt_player(@x_player, 'x')
      break if @positions.all? { |square| square.is_a? String }
      return if prompt_player(@o_player, 'o')
    end
    puts 'Draw'
  end

  # ask player which square
  def prompt_player(player, symbol)
    puts print_board
    empty_squares = @positions.select { |square| square.is_a? Integer }
    puts "This is round #{@round}"
    @positions[player.choose_square(empty_squares)] = symbol
    player.winner?(@positions)
  end
end

# Player
class Player
  def initialize(symbol, name, type)
    @symbol = symbol
    @winner_square_list = [
      [0, 1, 2], [3, 4, 5],
      [6, 7, 8], [0, 3, 6],
      [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
    @name = name
    @type = type
    puts "#{@name.capitalize} (#{@type}) will be #{@symbol}"
  end

  # is player a winner?
  def winner?(arr)
    is_tic_tac_toe = @winner_square_list.any? do |winner_square|
      all_equal?([arr[winner_square[0]], arr[winner_square[1]], arr[winner_square[2]]])
    end
    if is_tic_tac_toe
      puts "#{@name.capitalize} (#{@symbol}) has won, I knew #{@type}s are good."
      puts "But us computers predicted the winner, so we're the real winners\n"
      true
    else
      false
    end
  end

  private

  # is every element in this array equal?
  def all_equal?(arr)
    arr.uniq.length <= 1
  end
end

# Human
class HumanPlayer < Player
  def initialize(symbol)
    print 'What is your name? '
    @name = gets.chomp
    super(symbol, @name, 'human')
  end

  # prompt human player to choose a square
  def choose_square(empty_squares)
    print "#{@name.capitalize} (#{@symbol}), choose your square: "
    chosen_square = -1
    until empty_squares.any?(chosen_square.to_i)
      chosen_square = gets.chomp
      unless empty_squares.any?(chosen_square.to_i)
        print 'Invalid square, this is why computers need to be the dominant species, try again: '
      end
    end
    chosen_square.to_i - 1
  end
end

# Computer
class ComputerPlayer < Player
  def initialize(symbol)
    @name = "Computer_#{rand(1..999)}"
    super(symbol, @name, 'computer')
  end

  # computer generated square (computer has no skill and chooses any square)
  def choose_square(empty_squares)
    count_down
    pos = empty_squares[rand(0...empty_squares.length)]
    puts "Computer chose #{pos}"
    pos - 1
  end

  private

  # computer countdown (added this feature for fun)
  def count_down
    count_down = 3
    print "This super fast hyper sonic intellligent computer (#{@symbol}) will chose in: "
    until count_down.zero?
      print "#{count_down} "
      sleep(1)
      count_down -= 1
    end
  end
end

Game.new
