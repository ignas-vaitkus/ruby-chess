# frozen_string_literal: false

require_relative 'piece'

# Rook class
class Rook < Piece
  attr_reader :side

  def initialize(game, position, color)
    super
    @side = position[1].zero? ? :queen : :king
  end

  def take_castling_rights
    rights = side == :queen ? 'q' : 'k'

    rights.upcase! if color == 'white'

    game.send(:take_castling_rights, rights)
  end

  def move(destination)
    super
    take_castling_rights
  end

  def take
    super
    take_castling_rights
  end

  def moves
    DIRECTIONS.slice(:up, :down, :left, :right).flat_map(&iterate_direction(true))
  end

  def to_s
    color == 'white' ? '♜' : '♖'
  end
end
