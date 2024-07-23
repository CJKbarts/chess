# frozen_string_literal: true

class Piece
  attr_reader :symbol, :moves, :position

  def initialize(num, position)
    @position = position
    @symbol = assign_symbol(num)
    @moves = generate_moves
  end

  def update_position(new_position)
    @position = new_position
  end

  def valid_move?(coordinates)
    return false unless coordinates.all? { |index| (0..7).include?(index) }

    move = []
    move << coordinates[0] - position[0]
    move << coordinates[1] - position[1]
    moves.include?(move)
  end

  def generate_diagonal_moves
    move_array = []

    (0..7).each do |num|
      move_array << [num, num]
      move_array << [-num, -num]
      move_array << [num, -num]
      move_array << [-num, num]
    end

    move_array
  end

  def generate_straight_moves
    move_array = []

    (1..7).each do |num|
      move_array << [num, 0]
      move_array << [-num, 0]
      move_array << [0, num]
      move_array << [0, -num]
    end

    move_array
  end

  def to_s
    symbol
  end
end
