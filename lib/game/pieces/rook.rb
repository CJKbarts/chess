# frozen_string_literal: true

class Rook < Piece
  WHITE_SYMBOL = "\u2656"
  BLACK_SYMBOL = "\u265c"

  def assign_symbol(num)
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end

  def generate_moves
    generate_straight_moves
  end

  def adjacent_moves
    moves[0, 4]
  end
end
