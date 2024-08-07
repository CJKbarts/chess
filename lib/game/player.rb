class Player
  include Serializable
  attr_reader :num

  def initialize(num)
    @num = num
    @name = "Player #{num}"
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

  def to_s
    @name
  end

  def assign_name
    print "Player #{num} please enter your name: "
    @name = gets.chomp.capitalize
  end
end
