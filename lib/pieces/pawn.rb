# frozen_string_literal: true

require_relative 'piece'

# Pawn class
class Pawn < Piece
  def first_move?
    position[0] == (color == 'white' ? 6 : 1)
  end

  def direction
    color == 'white' ? -1 : 1
  end

  def moves
    # Logic for calculating valid moves for a pawn
    [*front_moves, *diagonal_moves]
  end

  def front_moves # rubocop:disable Metrics/AbcSize
    moves = []

    if game.board[position[0] + direction][position[1]].nil?
      moves << [position[0] + direction, position[1]]
      if game.board[position[0] + direction][position[1]].nil? && first_move?
        moves << [position[0] + (direction * 2), position[1]]
      end
    end

    moves
  end

  def diagonal_moves # rubocop:disable Metrics/AbcSize
    moves = []

    [[direction, 1], [direction, -1]].each do |move|
      checked_position = [position[0] + move[0], position[1] + move[1]]

      piece = game.board[checked_position[0]][checked_position[1]]

      next if piece.nil? && game.en_passant_square != checked_position

      moves << checked_position if piece&.color != color
    end

    moves
  end

  def take_pawn_by_en_passant(destination)
    return unless destination == game.en_passant_square

    taken_pawn = game.board[destination[0] - direction][destination[1]]
    taken_pawn&.take
  end

  def move(destination)
    raise ArgumentError, 'Invalid move' unless moves_after_check.include?(destination)

    take_pawn_by_en_passant(destination)

    game.board[destination[0]][destination[1]]&.take

    move_without_validation(destination)
  end

  def to_s
    color == 'white' ? '♟︎' : '♙'
  end
end
