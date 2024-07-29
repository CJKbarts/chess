# frozen_string_literal: true

class Piece
  attr_reader :symbol, :moves, :position, :num

  def initialize(num, position)
    @num = num
    @position = position
    @symbol = assign_symbol(num)
    @moves = generate_moves
  end

  def update_position(new_position)
    @position = new_position
  end

  def valid_move?(coordinates)
    move = []
    move << coordinates[0] - position[0]
    move << coordinates[1] - position[1]
    moves.include?(move)
  end

  def generate_diagonal_moves
    move_array = []

    (1..7).each do |num|
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

  def can_move?(board)
    adjacent_moves.any? do |move|
      coordinates = [position[0] + move[0], position[1] + move[1]]
      board.empty?(coordinates) || opp_piece?(board.piece(coordinates))
    end
  end

  def opp_piece?(piece)
    return false if piece.nil?

    num != piece.num
  end

  def to_s
    symbol
  end
end
