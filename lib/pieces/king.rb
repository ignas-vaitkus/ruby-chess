# frozen_string_literal: true

require_relative 'piece'

# King class
class King < Piece
  def check_for_check? # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    # Logic to determine if the King is in check

    DIRECTIONS.each_value do |value|
      checked_position = position
      loop do
        checked_position = [checked_position[0] + value[0], checked_position[1] + value[1]]
        break if checked_position.any? { |coord| coord.negative? || coord > 7 }

        piece = board[checked_position[0]][checked_position[1]]
        next if piece.nil?

        return true if piece.color != color && piece.moves.include?(position)

        break
      end
    end

    # Check for knights
    KNIGHT_MOVES.each do |move|
      checked_position = [position[0] + move[0], position[1] + move[1]]
      next if checked_position.any? { |coord| coord.negative? || coord > 7 }

      piece = board[checked_position[0]][checked_position[1]]
      next if piece.nil?

      return true if piece.color != color && piece.is_a?(Knight)
    end

    false
  end

  def moves
    []
  end

  def to_s
    color == 'white' ? '♚' : '♔'
  end
end
