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
    end.compact + castling_moves
  end

  def castling_letter(is_king_side)
    if color == 'white'
      is_king_side ? 'K' : 'Q'
    else
      is_king_side ? 'k' : 'q'
    end
  end

  def check_if_side_clear(is_king_side)
    range = is_king_side ? (position[1] + 1)...7 : 1...position[1]
    game.board[position[0]][range].each do |square|
      return false unless square.nil?
    end
    true
  end

  def side_castle_move(is_king_side) # rubocop:disable Metrics/AbcSize
    direction = is_king_side ? 1 : -1
    letter = castling_letter(is_king_side)

    castling_destination = [position[0], position[1] + (2 * direction)]
    castling_path = [[position[0], position[1] + direction], castling_destination]

    if game.castling_rights.include?(letter) && check_if_side_clear(is_king_side) && castling_path == moves_after_check(castling_path) && !in_check? # rubocop:disable Layout/LineLength
      castling_destination
    end
  end

  def castling_moves
    [side_castle_move(true), side_castle_move(false)].compact
  end

  def take_castling_rights
    rights = 'kq'

    rights.upcase! if color == 'white'

    game.send(:take_castling_rights, rights)
  end

  def castle_queen_side
    game.board[position[0]][0].move_without_validation([position[0], 3])
  end

  def castle_king_side
    game.board[position[0]][7].move_without_validation([position[0], 5])
  end

  def move(destination)
    castling = true if (position[1] - destination[1]).abs > 1
    is_queen_side_castle = (position[1] - destination[1]).positive?

    super

    if castling && is_queen_side_castle
      castle_queen_side
    elsif castling
      castle_king_side
    end

    take_castling_rights
  end

  def to_s
    color == 'white' ? '♚' : '♔'
  end
end
