# frozen_string_literal: true

class King < Piece
  WHITE_SYMBOL = "\u2654"
  BLACK_SYMBOL = "\u265A"

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

    move_array + [[0, 2], [0, -2]]
  end

  def update_position(new_position)
    super(new_position)
    moves.delete([0, 2])
    moves.delete([0, -2])
  end

  def special_move(destination, board)
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
    !has_moved && !rook.has_moved && board.clear_path?(position, destination)
  end

  def adjacent_moves(board)
    moves
  end
end
