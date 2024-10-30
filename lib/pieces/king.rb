# frozen_string_literal: true

require_relative 'piece'

# King class
class King < Piece
  def valid_moves
    # Logic to determine valid moves for the King
  end

  def to_s
    color == 'white' ? '♚' : '♔'
  end
end
