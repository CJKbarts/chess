require_relative '../lib/game/piece'
require_relative '../lib/game/pieces/pawn'
require_relative '../lib/game/display'
require_relative '../lib/game/board'

describe Pawn do
  describe 'moves' do
    subject(:pawn_generate) { described_class.new(1, [1, 0]) }

    context 'when the pawn has not been moved yet' do
      it 'can move two rows up or one row up' do
        expect(pawn_generate.moves).to eql([[1, 0], [2, 0]])
      end
    end

    context 'when the pawn has been moved' do
      before do
        pawn_generate.update_position([2, 0])
      end

      it 'can move only a single row up' do
        expect(pawn_generate.moves).to eql([[1, 0]])
      end
    end
  end

  describe '#adjacent_moves' do
    subject(:pawn_adjacent) { described_class.new(1, [1, 1]) }
    let(:board) { instance_double('Board') }

    context "when there's an opposing piece one square diagonally forward" do
      before do
        test_grid = Array.new(3) { Array.new(3, ' ') }
        allow(board).to receive(:grid).and_return(test_grid)
        allow(board).to receive(:piece).and_return(' ', Pawn.new(2, [2, 2]))
      end

      it 'can take the piece' do
        expect(pawn_adjacent.adjacent_moves(board)).to eql([[1, 0], [1, 1]])
      end
    end
  end
end
