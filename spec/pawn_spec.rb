require 'json'
require_relative '../lib/serializable'
require_relative '../lib/game/piece'
require_relative '../lib/game/pieces/pawn'
require_relative '../lib/game/pieces/king'
require_relative '../lib/game/display'
require_relative '../lib/game/board'

describe Pawn do
  describe '#can_move_twice?' do
    subject(:pawn_twice) { described_class.new(1, [0, 1]) }
    let(:board) { Board.new }

    context 'when the pawn has not been moved yet' do
      before do
        test_grid = Array.new(3) { Array.new(3, ' ') }
        test_grid[0][1] = pawn_twice
        board.instance_variable_set(:@grid, test_grid)
      end

      it 'returns true' do
        target_square = [2, 0]
        expect(pawn_twice.can_move_twice?(target_square, board)).to eql(true)
      end
    end

    context 'when the pawn has been moved' do
      before do
        pawn_twice.update_position([0, 2])
      end

      it 'returns false' do
        target_square = [2, 0]
        expect(pawn_twice.can_move_twice?(target_square, board)).to eql(false)
      end
    end
  end

  describe '#can_take?' do
    subject(:pawn_take) { described_class.new(1, [0, 1]) }
    let(:board) { Board.new }

    context 'when an opp piece is one square diagonally foward' do
      before do
        test_grid = Array.new(3) { Array.new(3, ' ') }
        test_grid[1][2] = instance_double('Pawn', num: 2)
        board.instance_variable_set(:@grid, test_grid)
      end

      it 'can take the opp piece' do
        take_move = [1, 1]
        expect(pawn_take.can_take?(take_move, board)).to eql(true)
      end
    end

    context 'when there is no piece one square diagonally forward' do
      before do
        test_grid = Array.new(3) { Array.new(3, ' ') }
        board.instance_variable_set(:@grid, test_grid)
      end

      it 'returns false' do
        take_move = [1, 1]
        expect(pawn_take.can_take?(take_move, board)).to eql(false)
      end
    end
  end

  describe '#can_take_en_passant?' do
    subject(:pawn_passant) { described_class.new(1, [0, 1]) }
    let(:opp_pawn) { Pawn.new(2, [2, 2]) }
    let(:board) { Board.new }

    context 'when an opp pawn moves two steps foward in previous turn' do
      before do
        test_grid = Array.new(3) { Array.new(3, ' ') }
        test_grid[0][1] = pawn_passant
        test_grid[2][2] = opp_pawn
        board.instance_variable_set(:@grid, test_grid)
        board.move([2, 2], [0, 2])
      end
      it 'returns true' do
        take_move = [1, 1]
        expect(pawn_passant.can_take_en_passant?(take_move, board)).to eql(true)
      end
    end

    context 'when an opp pawn moves two steps foward in turn before previous' do
      before do
        test_grid = Array.new(3) { Array.new(3, ' ') }
        test_grid[0][1] = pawn_passant
        test_grid[2][2] = opp_pawn
        test_grid[2][0] = Pawn.new(2, [2, 0])
        board.instance_variable_set(:@grid, test_grid)
        board.move([2, 2], [0, 2])
        board.move([2, 0], [1, 0])
      end
      it 'returns false' do
        take_move = [1, 1]
        expect(pawn_passant.can_take_en_passant?(take_move, board)).to eql(false)
      end
    end
  end
end
