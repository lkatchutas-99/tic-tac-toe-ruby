require_relative './human'
require_relative './computer'

# game class
class Game
  def initialize
    @positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @round = 0
  end

  def print_welcome_message
    puts "Welcome to tic tac toe!!!\nHere is the board,\n#{print_board}"
    puts 'The numbers represent which square you can choose to place your x or o'
    puts "\nx always goes first, human vs human is possible, and computer vs computer is possible\n"
    puts "\nRounds are endless unless the game is ended (type 'n' at the end of each round)\n"
    puts "How should the game be? type 'human' or 'computer' to select their symbol (x or o)\n"
  end

  def play_game
    setup_game
    exit_game = 'y'
    until exit_game.eql? 'n'
      play_round if exit_game.eql? 'y'
      print 'Do you want to play again? [y/n]: '
      exit_game = gets.chomp.downcase
    end
  end

  private

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
      prompt_player(@x_player, 'x')
      return if @x_player.winner?(@positions)
      break if @positions.all? { |square| square.is_a? String }
      prompt_player(@o_player, 'o')
      return if @o_player.winner?(@positions)
    end
    puts 'Draw'
  end

  # ask player which square
  def prompt_player(player, symbol)
    puts print_board
    empty_squares = @positions.select { |square| square.is_a? Integer }
    puts "This is round #{@round}"
    @positions[player.choose_square(empty_squares)] = symbol
  end
end