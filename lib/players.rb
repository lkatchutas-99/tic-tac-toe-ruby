
# Player
class Player
  attr_accessor :symbol, :winning_rows
  def initialize(symbol = '', name = '', type = '')
    @symbol = symbol
    @winning_rows = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], 
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
    @name = name
    @type = type
    puts "#{@name.capitalize} (#{@type}) will be #{@symbol}"
  end

  # is player a winner?
  def winner?(arr)
    is_tic_tac_toe = @winning_rows.any? do |winner_square|
      winner_square.all? { |num| arr[num] == @symbol }
    end

    if is_tic_tac_toe
      winner_prompt
      true
    else
      false
    end
  end

  private

  def winner_prompt
    puts "#{@name.capitalize} (#{@symbol}) has won, I knew #{@type}s are good."
    puts "But us computers predicted the winner, so we're the real winners\n"
  end
end