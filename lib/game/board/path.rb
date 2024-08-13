module Path
  def clear_path?(origin, destination)
    return true if piece(origin).instance_of?(Knight)

    if origin[0] == destination[0]
      horizontal_clear?(origin, destination)
    elsif origin[1] == destination[1]
      vertical_clear?(origin, destination)
    else
      diagonal_clear?(origin, destination)
    end
  end

  def horizontal_clear?(origin, destination)
    row = grid[origin[0]]
    start = lesser(origin[1], destination[1]) + 1
    length = (greater(origin[1], destination[1]) - start)
    line = row[start, length]
    line.all?(default_symbol)
  end

  def vertical_clear?(origin, destination)
    column = grid.map { |row| row[origin[1]] }
    start = lesser(origin[0], destination[0]) + 1
    length = (greater(origin[0], destination[0]) - start)
    line = column[start, length]
    line.all?(default_symbol)
  end

  def diagonal_clear?(origin, destination)
    diagonal(origin, destination).all?(default_symbol)
  end

  def diagonal(origin, destination)
    x_multiplier = destination[0] <=> origin[0]
    y_multiplier = destination[1] <=> origin[1]
    array = []
    difference = (destination[0] - origin[0]).abs

    (1..(difference - 1)).each do |increment|
      array << grid[origin[0] + (increment * x_multiplier)][origin[1] + (increment * y_multiplier)]
    end

    array
  end
end
