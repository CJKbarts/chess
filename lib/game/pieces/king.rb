# frozen_string_literal: true

class King < Piece
  WHITE_SYMBOL = "\u2654"
  BLACK_SYMBOL = "\u265A"

  def initialize(num, position)
    @type_num = 1
    super(num, position)
  end

  def assign_symbol
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end

  def generate_moves
    move_components = [1, 0, -1]
    move_array = []
    move_components.each do |row_index|
      move_components.each do |column_index|
        next if row_index == column_index && row_index.zero?

        move_array << [row_index, column_index]
      end
    end

    move_array
  end

  def update_position(new_position)
    super(new_position)
    moves.delete([0, 2])
    moves.delete([0, -2])
  end

  def adjacent_moves
    moves[0, 8]
  end

  def update_moves(board)
    @moves = moves[0, 8]
    [[position[0], 2], [position[0], 6]].each do |coordinate|
      moves << coordinate if can_castle?(coordinate, board)
    end
  end

  def valid_move?(coordinates, board)
    update_moves(board)
    super(coordinates)
  end

  def special_move(destination, board, player)
    return unless can_castle?(destination, board)

    board.move(position, destination)
    rook_initial_position = [position[0], destination[1] == 6 ? 7 : 0]
    rook_final_position = [position[0], rook_initial_position[1] == 7 ? 5 : 3]
    board.move(rook_initial_position, rook_final_position)
  end

  def can_castle?(destination, board)
    return false unless [[position[0], 6], [position[0], 2]].include?(destination)

    rook_column = destination[1] == 6 ? 7 : 0
    rook = board.piece([position[0], rook_column])
    return false unless rook.instance_of?(Rook)

    !has_moved && !rook.has_moved && paths_clear?(rook, destination, board)
  end

  def paths_clear?(rook, king_destination, board)
    king_path_clear?(king_destination, board) && rook_path_clear?(rook, board)
  end

  def king_path_clear?(destination, board)
    return false unless board.clear_path?(position, destination)

    column_multiplier = destination[1] <=> position[1]
    (1..2).none? do |increment|
      cell = [position[0], (position[1] + (increment * column_multiplier))]
      cell_checked?(cell, board)
    end
  end

  def rook_path_clear?(rook, board)
    destination = [rook.position[0], (rook.position[1] == 7 ? 5 : 3)]
    board.clear_path?(rook.position, destination)
  end

  def cell_checked?(position, board)
    board.grid.any? do |row|
      row.any? do |piece|
        next unless opp_piece?(piece)

        piece.valid_move?(position, board) && board.clear_path?(piece.position, position)
      end
    end
  end
end
