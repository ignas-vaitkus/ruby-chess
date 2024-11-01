# frozen_string_literal: true

require_relative 'piece'

# Knight class
class Knight < Piece
  def moves # rubocop:disable Metrics/AbcSize
    KNIGHT_MOVES.map do |move|
      checked_position = [position[0] + move[0], position[1] + move[1]]
      next if checked_position.any? { |coord| coord.negative? || coord > 7 }

      piece = game.board[checked_position[0]][checked_position[1]]
      next if piece&.color == color

      checked_position
    end.compact
  end

  def to_s
    color == 'white' ? '♞' : '♘'
  end
end
