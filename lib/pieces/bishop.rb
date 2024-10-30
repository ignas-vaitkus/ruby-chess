# frozen_string_literal: true

require_relative 'piece'

# Bishop class
class Bishop < Piece
  def valid_moves
    # Logic for calculating valid moves for a Bishop
  end

  def to_s
    color == 'white' ? '♝' : '♗'
  end
end
