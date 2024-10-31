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
end
