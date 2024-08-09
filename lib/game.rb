class Game
  include Serializable
  attr_reader :board, :player1, :player2, :current_player

  def initialize
    @board = Board.new
  end

  def setup
    setup_prompt
    gets.chomp == '1' ? new_game : load_game
  end

  def setup_prompt
    puts <<~SETUP
      [1] New Game
      [2] Load Game
    SETUP
    print ' > '
  end

  def play_round
    until game_over?
      board.display
      make_move(current_player)
      switch_player
    end
    board.display
    results
  end

  private

  def new_game
    puts
    board.generate_grid
    @player1 = Player.new(1).setup
    @player2 = Player.new(2).setup
    @current_player = player1
  end

  def load_game
    puts
    if Dir.exist?('saved_games') && !Dir.empty?('saved_games')
      filename = choose_savefile
      unserialize(File.read(filename))
    else
      puts 'You have no saved games. Start a new one'
      new_game
      nil
    end
  end

  def choose_savefile
    puts 'Choose a savefile: '
    save_files = Dir.children('saved_games')
    save_files.each_with_index { |name, index| puts "[#{index + 1}] #{name}" }
    input = gets.chomp.to_i - 1
    "saved_games/#{save_files[input]}"
  end

  def unserialize(string)
    obj = @@serializer.parse(string)
    @board = Board.new.unserialize(obj['@board'])
    @player1 = Player.new(1).unserialize(obj['@player1'])
    @player2 = Player.new(2).unserialize(obj['@player2'])
    @current_player = Player.new(1).unserialize(obj['@current_player']).num == 1 ? player1 : player2
    self
  end

  def save
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    path = "saved_games/savefile#{Dir.new('saved_games').children.length}.json"
    File.open(path, 'w') { |file| file.puts serialize }
    puts "Your game was saved in #{path}"
    exit
  end

  def serialize
    obj = {}
    instance_variables.each { |var| obj[var] = instance_variable_get(var).serialize }
    @@serializer.dump(obj)
  end

  def game_over?
    if board.king_taken
      switch_player
      return true
    end
    false
  end

  def make_move(player)
    origin = player.origin(board)
    save if origin == 'save'
    destination = player.destination(board, origin)
    save if destination == 'save'
    board.piece(origin).special_move(destination, board, player) || board.move(origin, destination)
  end

  def switch_player
    @current_player = @current_player == player1 ? player2 : player1
  end

  def results
    puts <<~RESULTS
      #{current_player} won the game!!
    RESULTS
  end
end
