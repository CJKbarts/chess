require 'json'
require_relative '../lib/serializable'
require_relative '../lib/game/piece'
require_relative '../lib/game/pieces/pawn'
require_relative '../lib/game/pieces/bishop'
require_relative '../lib/game/pieces/rook'

describe Piece do
  describe '#valid_move?' do
    subject(:rook_valid) { Rook.new(1, [1, 0]) }
    let(:board) { instance_double('Board') }

    before do
      allow(board).to receive(:piece)
    end

    context 'when an invalid move is given' do
      it 'returns false' do
        invalid_coordinate = [4, 4]
        expect(rook_valid.valid_move?(invalid_coordinate, board)).to eql(false)
      end

      it 'returns false' do
        invalid_coordinate = [2, 1]
        expect(rook_valid.valid_move?(invalid_coordinate, board)).to eql(false)
      end
    end

    context 'when a valid move is given' do
      it 'returns true' do
        valid_coordinate = [2, 0]
        expect(rook_valid.valid_move?(valid_coordinate, board)).to eql(true)
      end
    end
  end

  describe '#generate_diagonal_moves' do
    subject(:bishop_diagonal) { Bishop.new(1, [3, 3]) }
    let(:board) { instance_double('Board') }

    it 'can move up an increasing diagonal' do
      valid_move = [6, 6]
      expect(bishop_diagonal.valid_move?(valid_move, board)).to eql(true)
    end

    it 'can move down an increasing diagonal' do
      valid_move = [0, 0]
      expect(bishop_diagonal.valid_move?(valid_move, board)).to eql(true)
    end
    it 'can move up a decreasing diagonal' do
      valid_move = [6, 0]
      expect(bishop_diagonal.valid_move?(valid_move, board)).to eql(true)
    end
    it 'can move down a decreasing diagonal' do
      valid_move = [0, 6]
      expect(bishop_diagonal.valid_move?(valid_move, board)).to eql(true)
    end
  end

  describe '#generate_moves(board)' do
    subject(:rook_generate) { Rook.new(1, [3, 4]) }
    let(:board) { instance_double('Board') }

    it 'can move up a vertical line' do
      valid_move = [5, 4]
      expect(rook_generate.valid_move?(valid_move, board)).to eql(true)
    end

    it 'can move down a vertical line' do
      valid_move = [0, 4]
      expect(rook_generate.valid_move?(valid_move, board)).to eql(true)
    end

    it 'can move right on a horizontal line' do
      valid_move = [3, 5]
      expect(rook_generate.valid_move?(valid_move, board)).to eql(true)
    end

    it 'can move left on a horizontal line' do
      valid_move = [3, 1]
      expect(rook_generate.valid_move?(valid_move, board)).to eql(true)
    end
  end
end
