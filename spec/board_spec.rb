require_relative '../lib/game/display'
require_relative '../lib/game/piece'
require_relative '../lib/game/pieces/pawn'
require_relative '../lib/game/pieces/rook'
require_relative '../lib/game/pieces/knight'
require_relative '../lib/game/pieces/bishop'
require_relative '../lib/game/pieces/queen'
require_relative '../lib/game/pieces/king'
require_relative '../lib/game/board'

describe Board do
  describe '#coordinates' do
    subject(:board_coordinates) { described_class.new }
    let(:string) { 'f4' }

    it 'returns the coordinates of  chosen cell' do
      expect(board_coordinates.coordinates(string)).to eql([3, 5])
    end
  end
end
