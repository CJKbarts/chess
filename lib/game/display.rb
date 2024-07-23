# frozen_string_literal: true

module Display
  def display
    puts
    color = :white
    @grid.reverse.each_with_index do |row, row_index|
      print "#{8 - row_index} "
      print_row(color, row)
      color = switch_color(color)
    end
    print_column_letters
    puts
  end

  def print_row(color, row)
    row.each do |cell|
      print Rainbow(" #{cell} ").bg(color)
      color = switch_color(color)
    end
    puts
  end

  def print_column_letters
    print '   '
    ('a'..'h').each { |letter| print "#{letter}  " }
    puts
  end

  def switch_color(color)
    color == :white ? :black : :white
  end
end
