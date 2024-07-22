# frozen_string_literal: true

class Pawn < Piece
  WHITE_SYMBOL = "\u2659"
  BLACK_SYMBOL = "\u265F"

  def assign_symbol(num)
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end
end
