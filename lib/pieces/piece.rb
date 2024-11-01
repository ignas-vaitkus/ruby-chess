# frozen_string_literal: true

# Piece class
class Piece
  attr_reader :board, :color
  attr_accessor :position

  DIRECTIONS = {
    up: [-1, 0],
    down: [1, 0],
    left: [0, -1],
    right: [0, 1],
    up_left: [-1, -1],
    up_right: [-1, 1],
    down_left: [1, -1],
    down_right: [1, 1]
  }.freeze

  KNIGHT_MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def iterate_direction(is_nested_array) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    lambda do |direction|
      moves = []
      checked_position = position
      direction = direction[1] if is_nested_array

      loop do
        checked_position = [checked_position[0] + direction[0], checked_position[1] + direction[1]]
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
end
