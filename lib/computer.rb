require_relative './players'

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

  # computer countdown (added this feature to let the use glimps at the results)
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