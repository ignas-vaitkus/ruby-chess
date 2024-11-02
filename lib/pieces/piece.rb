# frozen_string_literal: true

# Piece class
class Piece
  attr_reader :game, :color
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

  def initialize(game, position, color)
    @game = game
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

        piece = game.board[checked_position[0]][checked_position[1]]
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

  def take
    game.taken_pieces[color.to_sym] << self
    self.own_square = nil
    self.position = nil
  end

  def own_square
    game.board[position[0]][position[1]]
  end

  def own_square=(square)
    game.board[position[0]][position[1]] = square
  end

  def moves
    []
  end

  # moves_after_check is used to filter out moves that would leave the king in check
  def moves_after_check # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    moves.select do |move|
      # Check if is an en passant move
      en_passant_move = is_a?(Pawn) && move == game.en_passant_square

      # Save the current state of the game
      taken_pawn = game.board[position[0]][move[1]] if en_passant_move
      destination_square = game.board[move[0]][move[1]]
      starting_position = position

      # Move the piece and check if the king is in check
      game.board[position[0]][move[1]] = nil if en_passant_move
      game.board[starting_position[0]][starting_position[1]] = nil
      game.board[move[0]][move[1]] = self
      self.position = move
      result = !game.kings[color].in_check?

      # Restore the game state
      game.board[position[0]][move[1]] = taken_pawn if en_passant_move
      game.board[starting_position[0]][starting_position[1]] = self
      game.board[move[0]][move[1]] = destination_square
      self.position = starting_position

      result
    end
  end

  def move_without_validation(destination)
    self.own_square = nil
    self.position = destination
    self.own_square = self
  end

  def move(destination)
    raise ArgumentError, 'Invalid move' unless moves_after_check.include?(destination)

    game.board[destination[0]][destination[1]]&.take

    move_without_validation(destination)
  end
end
