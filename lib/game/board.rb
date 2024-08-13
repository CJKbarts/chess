# frozen_string_literal: true

class Board
  include Grid
  include Path
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

  def valid_destination?(origin, destination, player_num)
    return true if destination == 'save'
    return false if piece(destination).nil?

    piece(origin).valid_move?(destination, self) && clear_path?(origin, destination) &&
      (empty?(destination) || piece(destination).num != player_num)
  end

  def move(origin, destination)
    @king_taken = true if piece(destination).instance_of?(King)
    moving_piece = piece(origin)
    set_piece(moving_piece, destination)
    set_piece(default_symbol, origin)
    moving_piece.update_position(destination)
    @previous_piece = moving_piece
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

  def lesser(x, y)
    x < y ? x : y
  end

  def greater(x, y)
    x > y ? x : y
  end
end
