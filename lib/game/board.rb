# frozen_string_literal: true

class Board
  include Display
  attr_reader :grid, :default_value

  def initialize
    @default_value = ' '
    @grid = create_grid
    populate_grid
  end

  private

  def populate_grid
    grid[1].fill(Pawn.new(1))
    grid[-2].fill(Pawn.new(2))
    populate_row(grid[0], 1)
    populate_row(grid[-1], 2)
  end

  def populate_row(row, color_num)
    row[0] = row[-1] = Rook.new(color_num)
    row[1] = row[-2] = Knight.new(color_num)
    row[2] = row[-3] = Bishop.new(color_num)
    row[3] = Queen.new(color_num)
    row[4] = King.new(color_num)
  end

  def create_grid
    Array.new(8) do
      Array.new(8) { default_value }
    end
  end
end
