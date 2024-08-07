class Game
  include Serializable
  attr_reader :board, :player1, :player2, :current_player

  def initialize
    @board = Board.new
    @player1 = Player.new(1)
    @player2 = Player.new(2)
    @current_player = player1
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
  end

  def new_game
    board.generate_grid
    player1.assign_name
    player2.assign_name
  end

  def play_round
    until game_over?
      board.display
      make_move(current_player)
      switch_player
    end
    results(current_player)
    board.display
  end

  def game_over?
    if board.king_taken
      switch_player
      true
    end
    false
  end

  def switch_player
    @current_player = @current_player == player1 ? player2 : player1
  end

  def make_move(player)
    origin = pick_origin(player)
    destination = pick_destination(player, origin)
    board.piece(origin).special_move(destination, board) || board.move(origin, destination)
  end

  def pick_origin(player)
    origin = player.input("#{player} please pick a valid piece to move: ")
    origin = player.input('Invalid piece. Please pick again: ') until board.valid_origin?(origin, player.num)
    save if origin == 'save'
    origin
  end

  def pick_destination(player, origin)
    destination = player.input("#{player} please pick a valid spot to move to: ")
    until board.valid_destination?(origin, destination, player.num)
      destination = player.input('Invalid spot. Pick again: ')
    end
    save if destination == 'save'
    destination
  end

  def results(winner)
    <<~RESULTS
      #{winner} won the game!!
    RESULTS
  end

  def serialize
    obj = {}
    instance_variables.each { |var| obj[var] = instance_variable_get(var).serialize }
    @@serializer.dump(obj)
  end

  def unserialize(string)
    obj = @@serializer.parse(string)
    @board = Board.new.unserialize(obj['@board'])
    @player1 = Player.new(1).unserialize(obj['@player1'])
    @player2 = Player.new(2).unserialize(obj['@player2'])
    @current_player = Player.new(1).unserialize(obj['@current_player'])
    self
  end

  def save
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    path = "saved_games/savefile#{Dir.new('saved_games').children.length}.json"
    File.open(path, 'w') { |file| file.puts serialize }
    puts "Your game was saved in #{path}"
    exit
  end

  def load_game
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
end
