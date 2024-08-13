module Grid
  def create_grid
    Array.new(8) do
      Array.new(8) { default_symbol }
    end
  end

  def populate_grid
    grid[1].fill { |column_index| Pawn.new(1, [1, column_index]) }
    grid[6].fill { |column_index| Pawn.new(2, [6, column_index]) }
    populate_row(0, 1)
    populate_row(7, 2)
  end

  def populate_row(row_num, color_num)
    row = grid[row_num]
    row[0] =  Rook.new(color_num, [row_num, 0])
    row[-1] = Rook.new(color_num, [row_num, 7])
    row[1] = Knight.new(color_num, [row_num, 1])
    row[-2] = Knight.new(color_num, [row_num, 6])
    row[2] = Bishop.new(color_num, [row_num, 2])
    row[-3] = Bishop.new(color_num, [row_num, 5])
    row[3] = Queen.new(color_num, [row_num, 3])
    row[4] = King.new(color_num, [row_num, 4])
  end

  def serialize_grid
    map_grid do |elm|
      elm.is_a?(Piece) ? elm.serialize : elm
    end
  end

  def unserialize_grid
    map_grid do |elm|
      if elm == default_symbol
        elm
      else
        generic_piece = Piece.new(1, [1, 1]).unserialize(elm)
        generic_piece.specify
      end
    end
  end

  def map_grid(&block)
    grid.map { |row| row.map(&block) }
  end

  def piece(coordinates)
    return nil unless coordinates.all? { |index| (0..7).include?(index) }

    grid[coordinates[0]][coordinates[1]]
  end

  def empty?(coordinates)
    piece(coordinates) == default_symbol
  end

  def set_piece(value, coordinates)
    grid[coordinates[0]][coordinates[1]] = value
  end
end
