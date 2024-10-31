# frozen_string_literal: true

require_relative 'piece'

# Pawn class
class Pawn < Piece
  def first_move?
    position[0] == (color == 'white' ? 6 : 1)
  end

  def moves
    # Logic for calculating valid moves for a pawn
    front_moves
  end

  def front_moves
    moves = []
    direction = color == 'white' ? -1 : 1

    if board[position[0] + direction][position[1]].nil?
      moves << [position[0] + direction, position[1]]
      if board[position[0] + direction][position[1]].nil? && first_move?
        moves << [position[0] + (direction * 2), position[1]]
      end
    end

    moves
  end

  def move(destination)
    raise ArgumentError, 'Invalid move' unless moves.include?(destination)

    board[position[0]][position[1]] = nil
    self.position = destination
    board[position[0]][position[1]] = self
  end

  def to_s
    color == 'white' ? '♟︎' : '♙'
  end
end
