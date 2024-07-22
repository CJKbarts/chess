# frozen_string_literal: true

class Bishop < Piece
  WHITE_SYMBOL = "\u2657"
  BLACK_SYMBOL = "\u265D"

  def assign_symbol(num)
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end
end
