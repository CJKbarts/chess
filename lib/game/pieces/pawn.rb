# frozen_string_literal: true

class Pawn < Piece
  WHITE_SYMBOL = "\u2659"
  BLACK_SYMBOL = "\u265F"
  attr_reader :row_increment

  def initialize(num, position)
    @row_increment = num == 1 ? 1 : -1
    super(num, position)
  end

  def assign_symbol
    num == 1 ? WHITE_SYMBOL : BLACK_SYMBOL
  end

  def generate_moves
    array = [[row_increment, 0]]
    array << [row_increment * 2, 0] unless has_moved
    array
  end

  def update_position(new_position)
    super
    moves.delete([row_increment * 2, 0])
  end

  def adjacent_moves(board)
    array = [moves[0]]
    [-1, 1].each do |column_increment|
      coordinates = [row_increment, column_increment]
      array << coordinates if opp_piece?(board.piece([position[0] + coordinates[0], position[1] + coordinates[1]]))
    end
    update_moves(array)
    array
  end

  def update_moves(array)
    @moves = (generate_moves + array).uniq
  end

  def special_move(destination, board)
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
