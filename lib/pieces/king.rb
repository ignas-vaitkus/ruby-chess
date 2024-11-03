# frozen_string_literal: false

require_relative 'knight'
require_relative 'piece'

# King class
class King < Piece
  def in_check? # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    # Logic to determine if the King is in check

    DIRECTIONS.each_value do |direction|
      checked_position = position
      loop do
        checked_position = [checked_position[0] + direction[0], checked_position[1] + direction[1]]
        break if checked_position.any? { |coord| coord.negative? || coord > 7 }

        piece = game.board[checked_position[0]][checked_position[1]]
        next if piece.nil?

        return true if piece.color != color && piece.moves.include?(position)

        break
      end
    end

    # Check for knights
    KNIGHT_MOVES.each do |move|
      checked_position = [position[0] + move[0], position[1] + move[1]]
      next if checked_position.any? { |coord| coord.negative? || coord > 7 }

      piece = game.board[checked_position[0]][checked_position[1]]
      next if piece.nil?

      return true if piece.color != color && piece.is_a?(Knight)
    end

    false
  end

  def moves # rubocop:disable Metrics/AbcSize
    DIRECTIONS.values.map do |direction|
      checked_position = [position[0] + direction[0], position[1] + direction[1]]
      next if checked_position.any? { |coord| coord.negative? || coord > 7 }

      piece = game.board[checked_position[0]][checked_position[1]]
      next if piece&.color == color

      checked_position
    end.compact
  end

  def move(destination)
    super

    rights = 'kq'

    rights.upcase! if color == 'white'

    game.send(:take_castling_rights, rights)
  end

  def to_s
    color == 'white' ? '♚' : '♔'
  end
end
