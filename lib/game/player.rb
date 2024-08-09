class Player
  include Serializable
  attr_reader :num, :name

  def initialize(num)
    @num = num
    @name = "Player #{num}"
    @type = 1
  end

  def setup
    input = setup_input
    puts
    case input
    when '1'
      assign_name("Player #{num} please enter your name: ")
      self
    when '2'
      player = ComputerPlayer.new(num)
      player.assign_name("Enter a name for #{name}: ")
      player
    end
  end

  def setup_input
    puts <<~PROMPT
      Choose the type of player you want for #{name}
      [1] Human Player
      [2] Computer Player
    PROMPT
    print ' > '
    gets.chomp
  end

  def origin(board)
    origin = input("#{name} please pick a valid piece to move: ")
    origin = input('Invalid piece. Please pick again: ') until board.valid_origin?(origin, num)
    origin
  end

  def destination(board, origin)
    destination = input("#{name} please pick a valid spot to move to: ")
    destination = input('Invalid spot. Pick again: ') until board.valid_destination?(origin, destination, num)
    destination
  end

  def input(prompt)
    print prompt
    choice = gets.chomp
    until verify_input(choice)
      print 'Invalid cell. Pick again: '
      choice = gets.chomp
    end
    choice == 'save' ? choice : coordinates(choice)
  end

  def verify_input(choice)
    if choice == 'save'
      true
    elsif choice.length != 2
      false
    else
      choice[0].match?(/[a-h]/) && choice[1].match?(/[1-8]/)
    end
  end

  def coordinates(string)
    column_index = string[0].downcase.ord % 97
    row_index = string[1].to_i - 1
    [row_index, column_index]
  end

  def chess_notation(coordinates)
    (97 + coordinates[1]).chr + (coordinates[0] + 1).to_s
  end

  def to_s
    name
  end

  def assign_name(prompt)
    print prompt
    @name = gets.chomp.capitalize
    puts
  end

  def unserialize(string)
    super
    return self unless @type == 2

    computer_player = ComputerPlayer.new(num)
    computer_player.instance_variables.each do |var|
      computer_player.instance_variable_set(var, instance_variable_get(var))
    end
    computer_player
  end

  def choose_promotion
    promotion_prompt
    gets.chomp
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
