# frozen_string_literal: true

class Queen < Piece
  WHITE_SYMBOL = "\u2655"
  BLACK_SYMBOL = "\u265B"

  def assign_symbol(num)
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end
end
