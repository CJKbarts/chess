# frozen_string_literal: true

module Display
  def display
    puts
    color = :white
    @grid.reverse.each do |row|
      print_row(color, row)
      color = switch_color(color)
    end
    puts
  end

  def print_row(color, row)
    row.each do |cell|
      print Rainbow(" #{cell} ").bg(color)
      color = switch_color(color)
    end
    puts
  end

  def switch_color(color)
    color == :white ? :black : :white
  end
end
