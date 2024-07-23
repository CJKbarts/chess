# frozen_string_literal: true

class King < Piece
  WHITE_SYMBOL = "\u2654"
  BLACK_SYMBOL = "\u265A"

  def assign_symbol(num)
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

    move_array
  end
end
