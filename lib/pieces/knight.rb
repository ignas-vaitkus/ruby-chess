# frozen_string_literal: true

require_relative 'piece'

# Knight class
class Knight < Piece
  def possible_moves # rubocop:disable Metrics/AbcSize
    x, y = position
    moves = [
      [x + 2, y + 1], [x + 2, y - 1],
      [x - 2, y + 1], [x - 2, y - 1],
      [x + 1, y + 2], [x + 1, y - 2],
      [x - 1, y + 2], [x - 1, y - 2]
    ]
    moves.select { |move| valid_move?(move) }
  end

  def valid_move?(move)
    move.all? { |coord| coord.between?(0, 7) }
  end

  def to_s
    color == 'white' ? '♞' : '♘'
  end
end
