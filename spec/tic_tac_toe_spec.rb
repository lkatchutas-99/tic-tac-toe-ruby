require_relative '../lib/game'
require_relative '../lib/players'
require_relative '../lib/human'
require_relative '../lib/computer'

describe Player do
  describe '#winner' do
    context 'When player did not win' do
      subject(:player_not_winning) { described_class.new('x', 'luka', 'human') }
      context 'When rows have no symbols' do
        it '#winner? with full board empty' do
          board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
          expect(player_not_winning.winner?(board)).to be false
        end
      end

      context 'when board has some symbols' do
        it '#winner? with one symbol returns false' do
          board = ['x', 2, 3, 4, 5, 6, 7, 8, 9]
          expect(player_not_winning.winner?(board)).to be false
        end

        it '#winner? with alternating symbols returns false' do
          board = ['x', 'o', 'x', 'x', 'o', 6, 7, 8, 9]
          expect(player_not_winning.winner?(board)).to be false
        end

        it '#winner? with symbol on different row' do
          board = [1, 'x', 'x', 'x', 5, 6, 7, 8, 9]
          expect(player_not_winning.winner?(board)).to be false
        end

        it '#winner? opposing symbol is false' do
          board = ['o', 'o', 'o', 4, 5, 6, 7, 8, 9]
          expect(player_not_winning.winner?(board)).to be false
        end
      end
    end

    context 'when player wins' do
      subject(:winning_player) { described_class.new('x', 'luka', 'human') }
      context 'When top row has all three symbols' do
        it '#winner? returns true' do
          board = ['x', 'x', 'x', 4, 5, 6, 7, 8, 9]
          expect(winning_player.winner?(board)).to be true
        end
      end

      context "When middle row has all three symbols" do
        it '#winner? returns true' do
          board = [1, 2, 3, 'x', 'x', 'x', 7, 8, 9]
          expect(winning_player.winner?(board)).to be true
        end
      end

      context "When bottom row has all three symbols" do
        it '#winner? returns true' do
          board = [1, 2, 3, 4, 5, 6, 'x', 'x', 'x']
          expect(winning_player.winner?(board)).to be true
        end
      end

      context 'When left column has all three symbols' do
        it '#winner? returns true' do
          board = ['x', 2, 3, 'x', 5, 6, 'x', 8, 9]
          expect(winning_player.winner?(board)).to be true
        end
      end
      context 'When middle column has all three symbols' do
        it '#winner? returns true' do
          board = [1, 'x', 3, 4, 'x', 6, 7, 'x', 9]
          expect(winning_player.winner?(board)).to be true
        end
      end
      
      context 'When right column has all three symbols' do
        it '#winner? returns true' do
          board = [1, 2, 'x', 4, 5, 'x', 7, 8, 'x']
          expect(winning_player.winner?(board)).to be true
        end
      end
      
      context 'When diagonal (downwards) has all three symbols' do
        it '#winner? returns true' do
          board = ['x', 2, 3, 4, 'x', 6, 7, 8, 'x']
          expect(winning_player.winner?(board)).to be true
        end
      end
      context 'When diagonal (upwards) has all three symbols' do
        it '#winner? returns true' do
          board = [1, 2, 'x', 4, 'x', 6, 'x', 8, 9]
          expect(winning_player.winner?(board)).to be true
        end
      end
    end
    
  end
end