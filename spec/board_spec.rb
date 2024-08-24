require 'json'
require_relative '../lib/serializable'
require_relative '../lib/game/board/grid'
require_relative '../lib/game/board/path'
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
  describe '#horizontal_clear?' do
    subject(:board_horizontal) { described_class.new }

    context 'when horizontal line between the two points is clear' do
      before do
        test_grid = [Array.new(8, board_horizontal.default_symbol)]
        test_grid[0][2] = instance_double('Queen')
        test_grid[0][6] = instance_double('Pawn')
        allow(board_horizontal).to receive(:grid).and_return(test_grid)
      end
      it 'returns true' do
        expect(board_horizontal.horizontal_clear?([0, 2], [0, 6], nil)).to eql(true)
      end
    end

    context 'when horizontal_line between the two points has other pieces' do
      before do
        test_grid = [Array.new(8, board_horizontal.default_symbol)]
        test_grid[0][2] = instance_double('Queen')
        test_grid[0][6] = instance_double('Pawn')
        test_grid[0][4] = instance_double('Pawn')
        allow(board_horizontal).to receive(:grid).and_return(test_grid)
      end
      it 'returns false' do
        expect(board_horizontal.horizontal_clear?([0, 2], [0, 6], nil)).to eql(false)
      end
    end

    context 'when a piece to be skipped is in the path' do
      let(:pawn_skip) { instance_double('Pawn') }
      before do
        test_grid = [Array.new(8, board_horizontal.default_symbol)]
        test_grid[0][2] = instance_double('Queen')
        test_grid[0][4] = pawn_skip
        test_grid[0][6] = instance_double('Pawn')
        allow(board_horizontal).to receive(:grid).and_return(test_grid)
      end
      it 'returns true' do
        expect(board_horizontal.horizontal_clear?([0, 2], [0, 6], pawn_skip)).to eql(true)
      end
    end
  end

  describe '#vertical_clear?' do
    subject(:board_vertical) { described_class.new }

    context 'when vertical line between two points is clear' do
      before do
        test_grid = Array.new(8) { Array.new(3, board_vertical.default_symbol) }
        test_grid[1][1] = instance_double('Queen')
        test_grid[5][1] = instance_double('Pawn')
        allow(board_vertical).to receive(:grid).and_return(test_grid)
      end
      it 'returns true' do
        expect(board_vertical.vertical_clear?([1, 1], [5, 1], nil)).to eql(true)
      end
    end

    context 'when vertical line between two points has other pieces' do
      before do
        test_grid = Array.new(8) { Array.new(3, board_vertical.default_symbol) }
        test_grid[1][1] = instance_double('Queen')
        test_grid[5][1] = instance_double('Pawn')
        test_grid[3][1] = instance_double('Pawn')
        allow(board_vertical).to receive(:grid).and_return(test_grid)
      end
      it 'returns false' do
        expect(board_vertical.vertical_clear?([1, 1], [5, 1], nil)).to eql(false)
      end
    end

    context 'when a piece to be skipped is in the path' do
      let(:pawn_skip) { instance_double('Pawn') }

      before do
        test_grid = Array.new(8) { Array.new(3, board_vertical.default_symbol) }
        test_grid[1][1] = instance_double('Queen')
        test_grid[4][1] = pawn_skip
        test_grid[5][1] = instance_double('Pawn')
        allow(board_vertical).to receive(:grid).and_return(test_grid)
      end
      it 'returns true' do
        expect(board_vertical.vertical_clear?([1, 1], [5, 1], pawn_skip)).to eql(true)
      end
    end
  end

  describe '#diagonal' do
    subject(:board_diagonal) { described_class.new }
    let(:pawn) { instance_double('Pawn') }

    context 'when the diagonal slopes upward' do
      before do
        test_grid = Array.new(5) { Array.new(5, board_diagonal.default_symbol) }

        test_grid[0][0] = pawn
        test_grid[1][1] = pawn
        test_grid[2][2] = pawn
        test_grid[3][3] = pawn
        test_grid[4][4] = pawn
        allow(board_diagonal).to receive(:grid).and_return(test_grid)
      end

      context 'when origin is at bottom' do
        it 'returns an array of elements in the line' do
          expect(board_diagonal.diagonal([0, 0], [4, 4])).to eql(Array.new(3, pawn))
        end
      end

      context 'when origin is at top' do
        it 'returns an array of elements in the line' do
          expect(board_diagonal.diagonal([4, 4], [0, 0])).to eql(Array.new(3, pawn))
        end
      end
    end

    context 'when the diagonal slopes downward' do
      before do
        test_grid = Array.new(5) { Array.new(5, board_diagonal.default_symbol) }

        test_grid[4][0] = pawn
        test_grid[3][1] = pawn
        test_grid[2][2] = pawn
        test_grid[1][3] = pawn
        test_grid[0][4] = pawn
        allow(board_diagonal).to receive(:grid).and_return(test_grid)
      end

      context 'when origin is at top' do
        it 'returns an array of elements in the line' do
          expect(board_diagonal.diagonal([4, 0], [0, 4])).to eql(Array.new(3, pawn))
        end
      end

      context 'when origin is at bottom' do
        it 'returns an array of elements in the line' do
          expect(board_diagonal.diagonal([0, 4], [4, 0])).to eql(Array.new(3, pawn))
        end
      end
    end
  end
end
