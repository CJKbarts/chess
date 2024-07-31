# frozen_string_literal: true

class Pawn < Piece
  WHITE_SYMBOL = "\u2659"
  BLACK_SYMBOL = "\u265F"
  attr_reader :row_increment, :board

  def initialize(num, position, board)
    @row_increment = num == 1 ? 1 : -1
    @board = board
    super(num, position)
  end

  def assign_symbol
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end

  def valid_move?(coordinates)
    @moves = generate_moves
    super(coordinates)
  end

  def generate_moves
    array = [[row_increment, 0]]
    take_moves = [[row_increment, -1], [row_increment, 1]]
    take_moves.each do |move|
      coordinates = move_to_coordinate(move)
      array << move if opp_piece?(board.piece(coordinates))
    end
    array << [row_increment * 2, 0] unless has_moved
    array
  end

  def update_position(position)
    super
    @moves = generate_moves
  end

  def adjacent_moves
    moves.reject { |move| move == [row_increment * 2, 0] }
  end

  def special_move(destination)
    return unless destination[0] == 0 || destination[0] == 7

    board.set_piece(promotion(destination), destination)
    board.set_piece(board.default_symbol, position)
  end

  def promotion(destination)
    promotion_prompt
    case gets.chomp
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

  def promotion_prompt
    print <<~PROMPT

      Choose a piece to upgrade to
      [1] Queen
      [2] Knight
      [3] Bishop
      [4] Rook
    PROMPT
  end
end
