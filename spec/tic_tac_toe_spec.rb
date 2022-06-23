require_relative '../lib/game'
require_relative '../lib/players'
require_relative '../lib/human'
require_relative '../lib/computer'

describe Player do
  describe '#winner' do
    context 'When player did not win' do
      subject(:player_not_winning) { described_class.new('x', 'luka', 'human') }
      context 'When rows have no symbols' do
      
        it '#winner? with top row returns false' do
          row = [1, 2, 3]
          expect(player_not_winning.winner?(row)).to be false
        end

        it '#winner? with middle row returns false' do
          row = [4, 5, 6]
          expect(player_not_winning.winner?(row)).to be false
        end

        it '#winner? with bottom row returns false' do
          row = [7, 8, 9]
          expect(player_not_winning.winner?(row)).to be false
        end
        it '#winner? with left column returns false' do
          column = [1, 4, 7]
          expect(player_not_winning.winner?(column)).to be false
        end
        it '#winner? with middle column returns false' do
          column = [2, 5, 8]
          expect(player_not_winning.winner?(column)).to be false
        end
        
        it '#winner? with right column returns false' do
          column = [3, 6, 9]
          expect(player_not_winning.winner?(column)).to be false
        end

        it '#winner? with diagonal facing downward returns false' do
          diagonal = [1, 5, 9]
          expect(player_not_winning.winner?(diagonal)).to be false
        end

        it '#winner? with diagonal facing upward returns false' do
          diagonal = [7, 5, 3]
          expect(player_not_winning.winner?(diagonal)).to be false
        end
        
        it '#winner? with full board empty' do
          board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        expect(player_not_winning.winner?(board)).to be false

        end
      end

      context 'when first row has some symbols' do
        it '#winner? with one symbol returns false' do
          row = ['x', 5, 9]
          expect(player_not_winning.winner?(row)).to be false
        end

        it '#winner? alternating symbols returns false' do
          row = ['x', 'o', 'x']
          expect(player_not_winning.winner?(row)).to be false
        end
      end
    end
    
  end
end