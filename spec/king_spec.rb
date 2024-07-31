require_relative '../lib/game/piece'
require_relative '../lib/game/display'
require_relative '../lib/game/board'
require_relative '../lib/game/pieces/pawn'
require_relative '../lib/game/pieces/king'

describe King do
  describe '#cell_checked?' do
    subject(:king_checked) { described_class.new(1, [1, 1], board) }
    let(:board) { instance_double('Board') }
    let(:pawn) { Pawn.new(2, [2, 0], board) }

    before do
      allow(board).to receive(:piece)
      allow(board).to receive(:piece).with([1, 1]).and_return(king_checked)
    end

    context 'when a cell is checked by a pawn' do
      before do
        test_grid = Array.new(3) { Array.new(3, ' ') }
        test_grid[1][1] = king_checked
        test_grid[2][0] = pawn
        allow(board).to receive(:grid).and_return(test_grid)
        allow(board).to receive(:clear_path?).and_return(true)
      end

      it 'it returns true' do
        expect(king_checked.cell_checked?([1, 1])).to eql(true)
      end
    end
  end
end
