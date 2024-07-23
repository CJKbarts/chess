# frozen_string_literal: true

class Board
  include Display
  attr_reader :grid, :default_value

  def initialize
    @default_value = ' '
    @grid = create_grid
    populate_grid
  end

  def empty?(x_index, y_index)
    grid[x_index][y_index] == default_value
  end

  def piece(coordinates)
    grid[coordinates[0]][coordinates[1]]
  end

  def move(old_coordinates, new_coordinates)
    grid[new_coordinates[0]][new_coordinates[1]] = piece(old_coordinates)
    grid[old_coordinates[0]][old_coordinates[1]] = default_value
  end

  private

  def populate_grid
    grid[1].fill { |column_index| Pawn.new(1, [1, column_index]) }
    grid[-2].fill { |column_index| Pawn.new(2, [-2, column_index]) }
    populate_row(0, 1)
    populate_row(-1, 2)
  end

  def populate_row(row_num, color_num)
    row = grid[row_num]
    row[0] =  Rook.new(color_num, [row_num, 0])
    row[-1] = Rook.new(color_num, [row_num, -1])
    row[1] = Knight.new(color_num, [row_num, 1])
    row[-2] = Knight.new(color_num, [row_num, -2])
    row[2] = Bishop.new(color_num, [row_num, 2])
    row[-3] = Bishop.new(color_num, [row_num, -3])
    row[3] = Queen.new(color_num, [row_num, 3])
    row[4] = King.new(color_num, [row_num, 4])
  end

  def create_grid
    Array.new(8) do
      Array.new(8) { default_value }
    end
  end
end
