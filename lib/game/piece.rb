# frozen_string_literal: true

class Piece
  attr_reader :symbol

  def initialize(num)
    @symbol = assign_symbol(num)
  end

  def to_s
    symbol
  end
end
