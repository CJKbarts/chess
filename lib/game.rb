class Game
  attr_reader :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new(1)
    @player2 = Player.new(2)
  end

  def setup
    board.generate_grid
    player1.assign_name
    player2.assign_name
  end

  def play_round
    current_player = nil
    until game_over?
      board.display
      current_player = choose_player(current_player)
      make_move(current_player)
    end
    results(current_player)
    board.display
  end

  def game_over?
    board.king_taken
  end

  def choose_player(player)
    player == player1 ? player2 : player1
  end

  def make_move(player)
    origin = player.input("#{player} choose a piece to move: ")
    origin = player.input('Invalid origin. Choose a different cell: ') until board.valid_origin?(origin, player.num)

    destination = player.input("#{player} choose a spot to move to: ")
    until board.valid_destination?(origin, destination, player.num)
      destination = player.input('Invalid destination. Choose a different cell: ')
    end

    board.piece(origin).special_move(destination) || board.move(origin, destination)
  end

  def results(winner)
    <<~RESULTS
      #{winner} won the game!!
    RESULTS
  end
end
