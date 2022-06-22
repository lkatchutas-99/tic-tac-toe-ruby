require_relative './players'

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