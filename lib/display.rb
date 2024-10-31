# frozen_string_literal: true

# Interface for displaying the board and match messages
class Display
  attr_reader :game

  UPPER_LOWER_BOARD = " abcdefgh\n"

  def initialize(game)
    @game = game
  end

  # Prints the board with the pieces in their current positions
  def board_to_s(board = game.board)
    board_string = UPPER_LOWER_BOARD

    board.each_with_index do |rank, i|
      rank_number = board.length - i
      row = rank_number.to_s

      row += rank.each_with_index.reduce('', &accumulate_rank(i))

      board_string += "#{row}#{rank_number}\n"
    end

    board_string + UPPER_LOWER_BOARD
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

  def print_beginning
    system('clear')
    puts "\n\nWelcome to Chess!\n\n"
  end

  def clear_and_print_header
    return unless game.retries.positive? || !game.moves.empty?

    system('clear')
    puts "\n\n\n\n"
  end

  def print_turn_info
    clear_and_print_header
    puts board_to_s
    puts "\n"
    puts game.message || "\n"
    puts "\n"
    puts "#{game.current_player.capitalize}, enter your move:\n\n"
  end
end
