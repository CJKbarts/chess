require 'json'
require_relative '../lib/serializable'
require_relative '../lib/game/piece'
require_relative '../lib/game/pieces/knight'

describe Knight do
  describe '#generate_moves' do
    subject(:knight_generate) { described_class.new(1, [4, 4]) }
    let(:board) { instance_double('Board') }

    it 'can move 2 up and 1 to the right' do
      valid_move = [6, 5]
      expect(knight_generate.valid_move?(valid_move, board)).to eql(true)
    end

    it 'can move 1 up and 2 to the right' do
      valid_move = [5, 6]
      expect(knight_generate.valid_move?(valid_move, board)).to eql(true)
    end

    it 'can move 2 down and 1 to the right' do
      valid_move = [2, 5]
      expect(knight_generate.valid_move?(valid_move, board)).to eql(true)
    end

    it 'can move 1 down and 2 to the left' do
      valid_move = [3, 2]
      expect(knight_generate.valid_move?(valid_move, board)).to eql(true)
    end

    it 'can move 2 down and 1 to the left' do
      valid_move = [2, 3]
      expect(knight_generate.valid_move?(valid_move, board)).to eql(true)
    end
  end
end
