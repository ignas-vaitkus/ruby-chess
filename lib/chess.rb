# frozen_string_literal: true

require_relative 'pieces/piece_factory'

# The chess game class
class Chess
  attr_reader :board

  UPPER_LOWER_BOARD = " abcdefgh\n"

  def initialize(starting_position = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR')
    @board = Array.new(8) { Array.new(8) }
    place_pieces(starting_position)
  end

  # '♖♘♗♕♔♗♘♖
  # ♙♙♙♙♙♙♙♙
  # ■□■□■□■□
  # □■□■□■□■
  # ■□■□■□■□
  # □■□■□■□■
  # ♟♟♟♟♟♟♟♟
  # ♜♞♝♛♚♝♞♜'

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

  def print_begining
    system('clear')
    puts "\n\nWelcome to Chess!\n\n"
  end

  public

  def play
    print_begining
    puts board_to_s

    puts "\n\n"

    puts "Enter your move:\n\n"

    gets.chomp
  end
end
