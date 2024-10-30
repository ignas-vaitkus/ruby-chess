# frozen_string_literal: true

require_relative 'piece'

# Pawn class
class Pawn < Piece
  def valid_moves
    # Logic for calculating valid moves for a pawn
  end

  def to_s
    color == 'white' ? '♟︎' : '♙'
  end
end
