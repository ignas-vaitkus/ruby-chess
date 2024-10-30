# frozen_string_literal: true

require_relative 'piece'

# Rook class
class Rook < Piece
  def valid_moves
    # Logic for rook's possible moves
  end

  def to_s
    color == 'white' ? '♜' : '♖'
  end
end
