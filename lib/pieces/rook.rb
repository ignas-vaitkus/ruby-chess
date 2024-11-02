# frozen_string_literal: true

require_relative 'piece'

# Rook class
class Rook < Piece
  def moves
    DIRECTIONS.slice(:up, :down, :left, :right).flat_map(&iterate_direction(true))
  end

  def to_s
    color == 'white' ? '♜' : '♖'
  end
end
