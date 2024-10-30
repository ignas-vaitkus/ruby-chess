# frozen_string_literal: true

# Piece class
class Piece
  attr_reader :board
  attr_accessor :position, :color

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def move(new_position)
    @position = new_position
  end
end
