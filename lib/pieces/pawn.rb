# frozen_string_literal: true

require_relative 'piece'

# Pawn class
class Pawn < Piece
  def first_move?
    position[0] == (color == 'white' ? 6 : 1)
  end

  def moves
    # Logic for calculating valid moves for a pawn
    [*front_moves, *diagonal_moves]
  end

  def front_moves # rubocop:disable Metrics/AbcSize
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

  def diagonal_moves # rubocop:disable Metrics/AbcSize
    moves = []
    direction = color == 'white' ? -1 : 1

    [[direction, 1], [direction, -1]].each do |move|
      next if board[position[0] + move[0]][position[1] + move[1]].nil?

      if board[position[0] + move[0]][position[1] + move[1]].color != color
        moves << [position[0] + move[0],
                  position[1] + move[1]]
      end
    end
  end

  def move(destination) # rubocop:disable Metrics/AbcSize
    raise ArgumentError, 'Invalid move' unless moves.include?(destination)

    board[position[0]][position[1]] = nil
    self.position = destination
    board[position[0]][position[1]] = self
  end

  def to_s
    color == 'white' ? '♟︎' : '♙'
  end
end
