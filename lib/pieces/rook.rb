# frozen_string_literal: true

require_relative 'piece'
require 'pry'

# Rook class
class Rook < Piece
  def valid_moves
    # Logic for rook's possible moves
  end

  def moves
    DIRECTIONS.slice(:up, :down, :left, :right).flat_map(&iterate_direction(true))
  end

  def to_s
    color == 'white' ? '♜' : '♖'
  end
end
