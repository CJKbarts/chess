require 'json'
require_relative '../lib/serializable'
require_relative '../lib/game/piece'
require_relative '../lib/game/display'
require_relative '../lib/game/board'
require_relative '../lib/game/pieces/pawn'
require_relative '../lib/game/pieces/king'
require_relative '../lib/game/pieces/knight'

describe King do
  describe '#cell_checked?' do
    subject(:king_checked) { described_class.new(1, [1, 1]) }
    let(:board) { Board.new }
    let(:pawn) { Pawn.new(2, [2, 0]) }

    context 'when a cell is checked by a pawn' do
      before do
        test_grid = Array.new(3) { Array.new(3, ' ') }
        test_grid[1][1] = king_checked
        test_grid[2][0] = pawn
        board.instance_variable_set(:@grid, test_grid)
      end

      it 'it returns true' do
        expect(king_checked.cell_checked?([1, 1], board)).to eql(true)
      end
    end
  end
end
