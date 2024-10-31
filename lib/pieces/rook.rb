# frozen_string_literal: true

require_relative 'piece'

# Rook class
class Rook < Piece
  def valid_moves
    # Logic for rook's possible moves
  end

  def moves # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    DIRECTIONS.slice(:up, :down, :left, :right).flat_map do |direction|
      moves = []
      checked_position = position

      loop do
        checked_position = [checked_position[0] + direction[1][0], checked_position[1] + direction[1][1]]
        break if checked_position.any? { |coord| coord.negative? || coord > 7 }

        piece = board[checked_position[0]][checked_position[1]]
        if piece.nil?
          moves << checked_position
        else
          moves << checked_position if piece.color != color
          break
        end
      end

      moves
    end
  end

  def to_s
    color == 'white' ? '♜' : '♖'
  end
end
