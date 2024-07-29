# frozen_string_literal: true

class Pawn < Piece
  WHITE_SYMBOL = "\u2659"
  BLACK_SYMBOL = "\u265F"

  def assign_symbol(num)
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end

  def generate_moves
    increment = symbol == WHITE_SYMBOL ? 1 : -1
    [[increment, 0], [increment * 2, 0]]
  end

  def update_position(new_position)
    super
    moves.pop if moves.length == 2
  end

  def adjacent_moves
    [moves[0]]
  end
end
