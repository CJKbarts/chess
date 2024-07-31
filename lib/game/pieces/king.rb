# frozen_string_literal: true

class King < Piece
  WHITE_SYMBOL = "\u2654"
  BLACK_SYMBOL = "\u265A"

  attr_reader :board

  def initialize(num, position, board)
    @board = board
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

    move_array + [[0, 2], [0, -2]]
  end

  def update_position(new_position)
    super(new_position)
    moves.delete([0, 2])
    moves.delete([0, -2])
  end

  def adjacent_moves
    moves[..-3]
  end

  def special_move(destination)
    return unless can_castle?(destination)

    board.move(position, destination)
    rook_initial_position = [position[0], destination[1] == 6 ? 7 : 0]
    rook_final_position = [position[0], rook_initial_position[1] == 7 ? 5 : 3]
    board.move(rook_initial_position, rook_final_position)
  end

  def can_castle?(destination)
    return false unless [[position[0], 6], [position[0], 2]].include?(destination)

    rook_column = destination[1] == 6 ? 7 : 0
    rook = board.piece([position[0], rook_column])
    !has_moved && !rook.has_moved && clear_path?(destination)
  end

  def clear_path?(destination)
    return false unless board.clear_path?(position, destination)

    column_multiplier = destination[1] <=> position[1]
    (1..2).none? do |increment|
      cell = [position[0], (position[1] + (increment * column_multiplier))]
      cell_checked?(cell)
    end
  end

  def cell_checked?(position)
    board.grid.each do |row|
      row.each do |piece|
        next unless opp_piece?(piece)
        return true if piece.valid_move?(position) && board.clear_path?(piece.position, position)
      end
    end
    false
  end
end
