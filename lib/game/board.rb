# frozen_string_literal: true

class Board
  include Display
  include Serializable
  attr_reader :grid, :default_symbol, :king_taken

  def initialize
    @default_symbol = ' '
    @king_taken = false
  end

  def generate_grid
    @grid = create_grid
    populate_grid
  end

  def valid_origin?(origin, player_num)
    return true if origin == 'save'
    return false if (current_piece = piece(origin)).nil?

    !empty?(origin) && current_piece.num == player_num && current_piece.can_move?(self)
  end

  def piece(coordinates)
    return nil unless coordinates.all? { |index| (0..7).include?(index) }

    grid[coordinates[0]][coordinates[1]]
  end

  def empty?(coordinates)
    piece(coordinates) == default_symbol
  end

  def valid_destination?(origin, destination, player_num)
    return true if destination == 'save'
    return false if piece(destination).nil?

    piece(origin).valid_move?(destination, self) && clear_path?(origin, destination) &&
      (empty?(destination) || piece(destination).num != player_num)
  end

  def clear_path?(origin, destination)
    return true if piece(origin).instance_of?(Knight)

    if origin[0] == destination[0]
      horizontal_clear?(origin, destination)
    elsif origin[1] == destination[1]
      vertical_clear?(origin, destination)
    else
      diagonal_clear?(origin, destination)
    end
  end

  def horizontal_clear?(origin, destination)
    row = grid[origin[0]]
    start = lesser(origin[1], destination[1]) + 1
    length = (greater(origin[1], destination[1]) - start)
    line = row[start, length]
    line.all?(default_symbol)
  end

  def vertical_clear?(origin, destination)
    column = grid.map { |row| row[origin[1]] }
    start = lesser(origin[0], destination[0]) + 1
    length = (greater(origin[0], destination[0]) - start)
    line = column[start, length]
    line.all?(default_symbol)
  end

  def diagonal_clear?(origin, destination)
    diagonal(origin, destination).all?(default_symbol)
  end

  def diagonal(origin, destination)
    x_multiplier = destination[0] <=> origin[0]
    y_multiplier = destination[1] <=> origin[1]
    array = []
    difference = (destination[0] - origin[0]).abs

    (1..(difference - 1)).each do |increment|
      array << grid[origin[0] + (increment * x_multiplier)][origin[1] + (increment * y_multiplier)]
    end

    array
  end

  def move(origin, destination)
    @king_taken = true if piece(destination).instance_of?(King)
    moving_piece = piece(origin)
    set_piece(moving_piece, destination)
    set_piece(default_symbol, origin)
    moving_piece.update_position(destination)
    @previous_piece = moving_piece
  end

  def set_piece(value, coordinates)
    grid[coordinates[0]][coordinates[1]] = value
  end

  def previous_piece?(piece)
    @previous_piece == piece
  end

  def serialize
    @grid = serialize_grid
    super
  end

  def unserialize(string)
    super
    @grid = unserialize_grid
    self
  end

  private

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

  def map_grid(&block)
    grid.map { |row| row.map(&block) }
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

  def lesser(x, y)
    x < y ? x : y
  end

  def greater(x, y)
    x > y ? x : y
  end
end
