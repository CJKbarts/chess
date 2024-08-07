# frozen_string_literal: true

class Knight < Piece
  WHITE_SYMBOL = "\u2658"
  BLACK_SYMBOL = "\u265E"

  def initialize(num, position)
    super
    @type_num = 4
  end

  def assign_symbol
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end

  def generate_moves
    move_components = [-1, 1, -2, 2]
    move_array = []

    move_components.each do |row_index|
      move_components.each do |column_index|
        next unless row_index.abs + column_index.abs == 3

        move_array << [row_index, column_index]
      end
    end

    move_array
  end

  def adjacent_moves
    moves
  end
end
