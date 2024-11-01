# frozen_string_literal: true

require_relative 'piece'

# Bishop class
class Bishop < Piece
  def moves
    # Logic for calculating moves for a Bishop
    DIRECTIONS.slice(:up_left, :up_right, :down_left, :down_right).flat_map(&iterate_direction(true))
  end

  def to_s
    color == 'white' ? '♝' : '♗'
  end
end
