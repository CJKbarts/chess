require_relative '../lib/game/piece'
require_relative '../lib/game/pieces/pawn'

describe Pawn do
  describe '#generate_moves' do
    subject(:pawn_generate) { described_class.new(1, [1, 0]) }

    it 'it can move only a single row up' do
      expect(pawn_generate.valid_move?([2, 0])).to eql(true)
    end

    context 'when the pawn has not been moved yet' do
      it 'it can move two rows up' do
        expect(pawn_generate.valid_move?([3, 0])).to eql(true)
      end
    end
  end
end
