# frozen_string_literal: true

require_relative 'piece'

# Queen class
class Queen < Piece
  def moves
    DIRECTIONS.values.flat_map(&iterate_direction(false))
  end

  def to_s
    color == 'white' ? '♛' : '♕'
  end
end
