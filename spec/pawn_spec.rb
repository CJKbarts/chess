require_relative '../lib/game/piece'
require_relative '../lib/game/pieces/pawn'
require_relative '../lib/game/display'
require_relative '../lib/game/board'

describe Pawn do
  describe '#generate_moves' do
    subject(:pawn_generate) { described_class.new(1, [1, 1], board) }
    let(:board) { instance_double('Board') }

    context 'when the pawn has not been moved yet' do
      before do
        allow(board).to receive(:piece)
      end

      it 'can move two rows up or one row up' do
        expect(pawn_generate.generate_moves).to eql([[1, 0], [2, 0]])
      end
    end

    context 'when the pawn has been moved' do
      before do
        allow(board).to receive(:piece)
        pawn_generate.update_position([2, 0])
      end

      it 'can move only a single row up' do
        expect(pawn_generate.moves).to eql([[1, 0]])
      end
    end

    context 'when an opp piece is one square diagonally foward' do
      before do
        opp_pawn = instance_double('Pawn', num: 2)
        allow(board).to receive(:piece).and_return(nil, opp_pawn)
      end

      it 'can take the opp piece' do
        expect(pawn_generate.moves).to eql([[1, 0], [1, 1], [2, 0]])
      end
    end
  end
end
