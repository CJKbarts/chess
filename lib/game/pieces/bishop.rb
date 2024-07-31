# frozen_string_literal: true

class Bishop < Piece
  WHITE_SYMBOL = "\u2657"
  BLACK_SYMBOL = "\u265D"

  def assign_symbol
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end

  def generate_moves
    generate_diagonal_moves
  end

  def adjacent_moves
    moves[0, 4]
  end
end
