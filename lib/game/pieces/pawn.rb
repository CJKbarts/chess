# frozen_string_literal: true

class Pawn < Piece
  WHITE_SYMBOL = "\u2659"
  BLACK_SYMBOL = "\u265F"

  def assign_symbol(num)
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end

  def generate_moves
    increment = symbol == WHITE_SYMBOL ? 1 : -1

    move_array = [[increment, 0]]
    move_array.prepend([increment * 2, 0]) if position[0] == 1 || position[0] == -2
    move_array
  end
end
