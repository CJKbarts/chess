require_relative '../lib/game/piece'
require_relative '../lib/game/pieces/pawn'
require_relative '../lib/game/pieces/bishop'
require_relative '../lib/game/pieces/rook'

describe Piece do
  describe '#valid_move?' do
    subject(:pawn_valid) { Pawn.new(1, [1, 0]) }

    context 'when an out of bounds coordinate is given' do
      it 'returns false' do
        invalid_coordinate = [10, 5]
        expect(pawn_valid.valid_move?(invalid_coordinate)).to eql(false)
      end

      context 'when the move is valid otherwise' do
        before do
          pawn_valid.instance_variable_set(:@position, [7, 5])
        end

        it 'returns false' do
          invalid_coordinate = [8, 5]
          expect(pawn_valid.valid_move?(invalid_coordinate)).to eql(false)
        end
      end
    end

    context 'when an invalid move is given' do
      it 'returns false' do
        invalid_coordinate = [4, 0]
        expect(pawn_valid.valid_move?(invalid_coordinate)).to eql(false)
      end

      it 'returns false' do
        invalid_coordinate = [4, 5]
        expect(pawn_valid.valid_move?(invalid_coordinate)).to eql(false)
      end
    end

    context 'when a valid move is given' do
      it 'returns true' do
        valid_coordinate = [2, 0]
        expect(pawn_valid.valid_move?(valid_coordinate)).to eql(true)
      end
    end
  end

  describe '#generate_diagonal_moves' do
    subject(:bishop_diagonal) { Bishop.new(1, [3, 3]) }

    it 'can move up an increasing diagonal' do
      valid_move = [6, 6]
      expect(bishop_diagonal.valid_move?(valid_move)).to eql(true)
    end

    it 'can move down an increasing diagonal' do
      valid_move = [0, 0]
      expect(bishop_diagonal.valid_move?(valid_move)).to eql(true)
    end
    it 'can move up a decreasing diagonal' do
      valid_move = [6, 0]
      expect(bishop_diagonal.valid_move?(valid_move)).to eql(true)
    end
    it 'can move down a decreasing diagonal' do
      valid_move = [0, 6]
      expect(bishop_diagonal.valid_move?(valid_move)).to eql(true)
    end
  end

  describe '#generate_moves' do
    subject(:rook_generate) { Rook.new(1, [3, 4]) }

    it 'can move up a vertical line' do
      expect(rook_generate.valid_move?([5, 4])).to eql(true)
    end

    it 'can move down a vertical line' do
      expect(rook_generate.valid_move?([0, 4])).to eql(true)
    end

    it 'can move right on a horizontal line' do
      expect(rook_generate.valid_move?([3, 5])).to eql(true)
    end

    it 'can move left on a horizontal line' do
      expect(rook_generate.valid_move?([3, 1])).to eql(true)
    end
  end
end
