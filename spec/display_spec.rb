# frozen_string_literal: true

require 'rspec'
require_relative '../lib/pieces/rook'
require_relative '../lib/display'

RSpec.describe Display do
  let(:empty_board) { Array.new(8) { Array.new(8) } }
  let(:chess) do
    Chess.new
  end

  describe '#board_to_s' do
    it 'displays an empty board correctly' do
      expected_output = " abcdefgh\n8■□■□■□■□8\n7□■□■□■□■7\n6■□■□■□■□6\n5□■□■□■□■5\n4■□■□■□■□4\n3□■□■□■□■3\n2■□■□■□■□2\n1□■□■□■□■1\n abcdefgh\n" # rubocop:disable Layout/LineLength

      expect(chess.display.board_to_s(empty_board)).to eq(expected_output)
    end

    it 'displays a populated board correctly' do
      expected_output = " abcdefgh\n8♖♘♗♕♔♗♘♖8\n7♙♙♙♙♙♙♙♙7\n6■□■□■□■□6\n5□■□■□■□■5\n4■□■□■□■□4\n3□■□■□■□■3\n2♟︎♟︎♟︎♟︎♟︎♟︎♟︎♟︎2\n1♜♞♝♛♚♝♞♜1\n abcdefgh\n" # rubocop:disable Layout/LineLength

      expect(chess.display.board_to_s).to eq(expected_output)
    end
  end

  describe '#print_beginning' do
    it 'clears the screen and prints the welcome message' do
      expect { chess.display.print_beginning }.to output("\n\nWelcome to Chess!\n\n").to_stdout
    end
  end

  describe '#print_turn_info' do
    it 'prints the turn information' do
      allow(described_class).to receive(:system).with('clear')

      expected_output = " abcdefgh\n8♖♘♗♕♔♗♘♖8\n7♙♙♙♙♙♙♙♙7\n6■□■□■□■□6\n5□■□■□■□■5\n4■□■□■□■□4\n3□■□■□■□■3\n2♟︎♟︎♟︎♟︎♟︎♟︎♟︎♟︎2\n1♜♞♝♛♚♝♞♜1\n abcdefgh\n\n\n\nWhite, enter your move:\n\n" # rubocop:disable Layout/LineLength

      expect do
        chess.display.print_turn_info
      end.to output(expected_output).to_stdout
    end
  end
end
