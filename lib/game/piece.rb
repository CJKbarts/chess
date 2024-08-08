# frozen_string_literal: true

class Piece
  include Serializable
  attr_reader :symbol, :moves, :position, :num, :has_moved, :type_num

  def initialize(num, position)
    @num = num
    @position = position
    @symbol = assign_symbol
    @moves = generate_moves
    @has_moved = false
  end

  def can_move?(board = nil)
    adjacent_moves.any? do |move|
      coordinates = move_to_coordinate(move)
      board.empty?(coordinates) || opp_piece?(board.piece(coordinates))
    end
  end

  def special_move(destination, board)
  end

  def valid_move?(coordinates, board = nil)
    move = []
    move << coordinates[0] - position[0]
    move << coordinates[1] - position[1]
    moves.include?(move)
  end

  def update_position(new_position)
    @position = new_position
    @has_moved = true
  end

  def specify
    piece = new_child
    instance_variables.each { |var| piece.instance_variable_set(var, instance_variable_get(var)) }
    piece
  end

  private

  def assign_symbol
  end

  def generate_moves
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

  def opp_piece?(piece)
    return false if piece.nil? || piece == ' '

    num != piece.num
  end

  def to_s
    symbol
  end

  def move_to_coordinate(move)
    [position[0] + move[0], position[1] + move[1]]
  end

  def coordinates_to_move(destination, origin)
    [destination[0] - origin[0], destination[1] - origin[1]]
  end

  def new_child
    case type_num
    when 0
      Pawn.new(num, position)
    when 1
      King.new(num, position)
    when 2
      Queen.new(num, position)
    when 3
      Bishop.new(num, position)
    when 4
      Knight.new(num, position)
    when 5
      Rook.new(num, position)
    end
  end
end
