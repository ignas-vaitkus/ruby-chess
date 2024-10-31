# frozen_string_literal: true

# Piece class
class Piece
  attr_reader :board, :color
  attr_accessor :position

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end
end
