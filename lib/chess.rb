# frozen_string_literal: true

# The chess game object
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

  def place_pieces(starting_position) # rubocop:disable Metrics/MethodLength
    starting_position.split('/').each_with_index do |rank, i|
      file = 0
      rank.each_char do |char|
        if char.match?(/\d/)
          file += char.to_i
        else
          board[i][file] = char
          file += 1
        end
      end
    end
  end

  # prints the board with pieces on it
  def board_to_s # rubocop:disable Metrics/AbcSize
    UPPER_LOWER_BOARD +
      board.each_with_index.reduce('') do |rank_acc, (rank, i)|
        rank_no = board.length - i
        rank_acc + rank_no.to_s +
          rank.each_with_index.reduce('') do |file_acc, (file, j)|
            file_acc + (file || ((i + j).even? ? '■' : '□'))
          end + "#{rank_no}\n"
      end +
      UPPER_LOWER_BOARD
  end

  def play
    puts board_to_s
  end
end
