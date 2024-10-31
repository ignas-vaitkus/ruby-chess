# frozen_string_literal: true

require_relative 'display'
require_relative 'pieces/piece_factory'

# The chess game class
class Chess
  attr_reader :board, :display
  attr_accessor :current_player, :moves, :message, :retries

  def initialize(starting_position = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w')
    @board = Array.new(8) { Array.new(8) }
    @display = Display.new(self)
    starting_piece_placement, current_player_letter = starting_position.split
    @current_player = current_player_letter == 'w' ? 'white' : 'black'
    @moves = []
    place_pieces(starting_piece_placement)
    @retries = 0
  end

  private

  def place_pieces(starting_position) # rubocop:disable Metrics/MethodLength
    starting_position.split('/').each_with_index do |rank, i|
      file = 0
      rank.each_char do |char|
        if char.match?(/\d/)
          file += char.to_i
        else
          board[i][file] = PieceFactory.create_piece(board, char, [i, file])
          file += 1
        end
      end
    end
  end

  def handle_turn_end
    self.current_player = current_player == 'white' ? 'black' : 'white'
    self.retries = 0
    self.message = nil
  end

  def play_turn
    display.print_turn_info
    input = gets.chomp
    handle_input?(input)
    handle_turn_end
    play_turn
  rescue StandardError => e
    self.retries += 1
    self.message = e
    retry
  end

  def valid_coordinate_notation_move(move)
    return if move.match?(/^[A-H][1-8]-[A-H][1-8]$/)

    raise ArgumentError, 'Invalid input, use coordinate notation, for example "A2-A4", "B1-C3", etc.'
  end

  def pick_start_and_destination(move)
    move.split('-').map do |position|
      [8 - position[1].to_i, position[0].ord - 65]
    end
  end

  def handle_input?(move)
    valid_coordinate_notation_move(move)
    start, destination = pick_start_and_destination(move)
    piece = pick_piece(start)
    piece.move(destination)
    moves << { destination: destination, move: move, piece: piece }
  end

  def pick_piece(square)
    piece = board[square[0]][square[1]]
    raise ArgumentError, 'No piece at that position.' if piece.nil?
    raise ArgumentError, 'Not your piece.' if piece.color != current_player

    piece
  end

  public

  def play
    display.print_beginning

    play_turn
  end
end
