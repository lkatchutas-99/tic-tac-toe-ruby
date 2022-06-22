
# Player
class Player
  def initialize(symbol, name, type)
    @symbol = symbol
    @winner_square_list = [
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
    is_tic_tac_toe = @winner_square_list.any? do |winner_square|
      all_equal?([arr[winner_square[0]], arr[winner_square[1]], arr[winner_square[2]]])
    end

    if is_tic_tac_toe
      winner_prompt
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

  def winner_prompt
    puts "#{@name.capitalize} (#{@symbol}) has won, I knew #{@type}s are good."
    puts "But us computers predicted the winner, so we're the real winners\n"
  end
end