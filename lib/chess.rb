# frozen_string_literal: true

require_relative 'pieces/piece_factory'

# The chess game class
class Chess
  attr_reader :board
  attr_accessor :current_player, :moves, :message, :retries

  UPPER_LOWER_BOARD = " abcdefgh\n"
  def initialize(starting_position = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w')
    @board = Array.new(8) { Array.new(8) }
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

  def accumulate_rank(rank_index)
    lambda do |acc, (file, j)|
      acc + if file.nil?
              (rank_index + j).even? ? '■' : '□'
            else
              file.to_s
            end
    end
  end

  # prints the board with pieces on it
  def board_to_s
    board_string = UPPER_LOWER_BOARD.dup

    board.each_with_index do |rank, i|
      rank_number = board.length - i
      row = rank_number.to_s

      row += rank.each_with_index.reduce('', &accumulate_rank(i))

      board_string << "#{row}#{rank_number}\n"
    end

    board_string + UPPER_LOWER_BOARD
  end

  def print_beginning
    system('clear')
    puts "\n\nWelcome to Chess!\n\n"
  end

  def print_turn_info
    if retries.positive? || !moves.empty?
      system('clear')
      puts "\n\n\n\n"
    end
    puts board_to_s
    puts "\n"
    puts message || "\n"
    puts "\n"
    puts "#{current_player.capitalize}, enter your move:\n\n"
  end

  def play_turn
    print_turn_info
    input = gets.chomp
    handle_input?(input)
  rescue StandardError => e
    self.retries += 1
    self.message = e
    retry
  end

  def valid_coordinate_notation_move(move)
    return if move.match?(/^[A-H][1-8]-[A-H][1-8]$/)

    raise ArgumentError, 'Invalid input, use coordinate notation, for example "A2-A4", "B1-C3", etc.'
  end

  def handle_input?(move)
    valid_coordinate_notation_move(move)
    pick_piece(move)
  end

  def pick_piece(move)
    from, = move.split('-')
    piece = board[8 - from[1].to_i][from[0].ord - 65]
    raise 'No piece at that position.' if piece.nil?
    raise 'Not your piece.' if piece.color != current_player

    piece
  end

  public

  def play
    print_beginning

    play_turn
  end
end
