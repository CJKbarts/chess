require_relative '../lib/game/piece'
require_relative '../lib/game/pieces/pawn'
require_relative '../lib/game/display'
require_relative '../lib/game/board'

describe Pawn do
  describe '#generate_moves' do
    subject(:pawn_generate) { described_class.new(1, [1, 0]) }

    it 'can move only a single row up' do
      expect(pawn_generate.valid_move?([2, 0])).to eql(true)
    end

    context 'when the pawn has not been moved yet' do
      it 'can move two rows up' do
        expect(pawn_generate.valid_move?([3, 0])).to eql(true)
      end
    end

    context 'when the pawn has been moved' do
      before do
        pawn_generate.update_position([2, 0])
      end

      it 'cannot move two rows up' do
        expect(pawn_generate.valid_move?([4, 0])).to eql(false)
      end
    end
  end
end
