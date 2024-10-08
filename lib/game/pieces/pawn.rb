# frozen_string_literal: true

class Pawn < Piece
  WHITE_SYMBOL = "\u2659"
  BLACK_SYMBOL = "\u265F"
  attr_reader :row_increment

  def initialize(num, position)
    @row_increment = num == 1 ? 1 : -1
    @type_num = 0
    super(num, position)
  end

  def assign_symbol
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end

  def generate_moves
    [[row_increment, 0]]
  end

  def update_moves(board)
    array = [[row_increment, -1], [row_increment, 1], [row_increment * 2, 0]]
    @moves = array.filter do |move|
      can_take?(move, board) || can_take_en_passant?(move, board) || can_move_twice?(move, board)
    end
    @moves << [row_increment, 0] if board.empty?(move_to_coordinate([row_increment, 0]))
  end

  def can_move?(board)
    board.empty?(move_to_coordinate([row_increment, 0])) || take_possible?(board)
  end

  def take_possible?(board)
    take_moves = [[row_increment, -1], [row_increment, 1]]
    take_moves.any? { |move| can_take?(move, board) || can_take_en_passant?(move, board) }
  end

  def can_take?(move, board)
    return false unless [[row_increment, -1], [row_increment, 1]].include? move

    coordinates = move_to_coordinate(move)
    opp_piece?(board.piece(coordinates))
  end

  def can_take_en_passant?(move, board)
    return false unless [[row_increment, -1], [row_increment, 1]].include? move

    coordinates = move_to_coordinate([0, move[1]])
    adjacent_piece = board.piece(coordinates)
    opp_piece?(adjacent_piece) && adjacent_piece.instance_of?(Pawn) &&
      board.previous_piece?(adjacent_piece) && adjacent_piece.moved_twice?
  end

  def can_move_twice?(move, board)
    return false unless move == [row_increment * 2, 0]

    !has_moved && board.empty?(move_to_coordinate([row_increment, 0]))
  end

  def valid_move?(coordinates, board)
    update_moves(board)
    super(coordinates, board)
  end

  def update_position(new_position)
    @previous_move = coordinates_to_move(new_position, position)
    super(new_position)
  end

  def moved_twice?
    @previous_move == [row_increment * 2, 0]
  end

  def adjacent_moves
    moves
  end

  def special_move(destination, board, player)
    move = coordinates_to_move(destination, position)
    if destination[0] == 0 || destination[0] == 7
      promote(destination, board, player)
    elsif can_take?(move, board) || can_move_twice?(move, board)
      board.move(position, destination)
    elsif can_take_en_passant?(move, board)
      take_en_passant(destination, board)
    end
  end

  def take_en_passant(destination, board)
    board.set_piece(board.default_symbol, [position[0], destination[1]])
    board.move(position, destination)
  end

  def promote(destination, board, player)
    board.set_piece(promotion(destination, player), destination)
    board.set_piece(board.default_symbol, position)
  end

  def promotion(destination, player)
    case player.choose_promotion
    when '1'
      Queen.new(num, destination)
    when '2'
      Knight.new(num, destination)
    when '3'
      Bishop.new(num, destination)
    when '4'
      Rook.new(num, destination)
    end
  end
end
