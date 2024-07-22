# frozen_string_literal: true

class Knight < Piece
  WHITE_SYMBOL = "\u2658"
  BLACK_SYMBOL = "\u265E"

  def assign_symbol(num)
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end
end
