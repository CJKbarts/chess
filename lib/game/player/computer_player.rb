class ComputerPlayer < Player
  def initialize(num)
    super
    @type = 2
  end

  def origin(board)
    chosen_piece = choose_piece(board)
    chosen_piece.position
  end

  def choose_piece(board)
    pieces = board.grid.flatten.filter { |piece| piece.is_a?(Piece) && piece.num == num }
    movable_pieces = pieces.filter { |piece| piece.can_move?(board) }
    movable_pieces.sample
  end

  def destination(board, origin)
    moving_piece = board.piece(origin)
    move = choose_move(moving_piece, board, origin)
    destination = moving_piece.move_to_coordinate(move)
    sleep(1.5)
    puts "#{name} moved #{chess_notation(origin)} to #{chess_notation(destination)}"
    destination
  end

  def choose_move(piece, board, origin)
    piece.update_moves(board)
    possible_moves = piece.moves.filter do |move|
      destination = piece.move_to_coordinate(move)
      board.valid_destination?(origin, destination, num)
    end
    possible_moves.sample
  end

  def choose_promotion
    (1..4).to_a.sample.to_s
  end
end
