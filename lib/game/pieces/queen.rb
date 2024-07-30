# frozen_string_literal: true

class Queen < Piece
  WHITE_SYMBOL = "\u2655"
  BLACK_SYMBOL = "\u265B"

  def assign_symbol
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end

  def generate_moves
    generate_diagonal_moves + generate_straight_moves
  end

  def adjacent_moves(board)
    moves[0, 4] + moves[28, 4]
  end
end
