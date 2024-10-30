# frozen_string_literal: true

require_relative 'piece'

# Queen class
class Queen < Piece
  def valid_moves
    # Logic for calculating possible moves for the Queen
  end

  def to_s
    color == 'white' ? '♛' : '♕'
  end
end
