# frozen_string_literal: true

# require 'minitest/autorun'
require_relative '../lib/chess'

describe Chess do
  let(:random_position) { '4k3/8/8/8/8/8/7P/4K3' }

  describe '#board_to_s' do
    it 'returns starting position when instantiated without arguments' do
      expect(described_class.new.send(:board_to_s)).to eql(" abcdefgh\n8♖♘♗♕♔♗♘♖8\n7♙♙♙♙♙♙♙♙7\n6■□■□■□■□6\n5□■□■□■□■5\n4■□■□■□■□4\n3□■□■□■□■3\n2♟︎♟︎♟︎♟︎♟︎♟︎♟︎♟︎2\n1♜♞♝♛♚♝♞♜1\n abcdefgh\n") # rubocop:disable Layout/LineLength
    end

    it 'returns position when instantiated with random Forsyth–Edwards Notation position' do
      expect(described_class.new(random_position).send(:board_to_s)).to eql(" abcdefgh\n8■□■□♔□■□8\n7□■□■□■□■7\n6■□■□■□■□6\n5□■□■□■□■5\n4■□■□■□■□4\n3□■□■□■□■3\n2■□■□■□■♟︎2\n1□■□■♚■□■1\n abcdefgh\n") # rubocop:disable Layout/LineLength
    end
  end

  describe 'print_beginning' do
    it 'prints the starting message' do
      expect { described_class.new.send(:print_beginning) }.to output("\n\nWelcome to Chess!\n\n").to_stdout
    end
  end

  describe 'print_turn_info' do
    it 'prints the turn info' do
      expect do
        described_class.new.send(:print_turn_info)
      end.to output(" abcdefgh\n8♖♘♗♕♔♗♘♖8\n7♙♙♙♙♙♙♙♙7\n6■□■□■□■□6\n5□■□■□■□■5\n4■□■□■□■□4\n3□■□■□■□■3\n2♟︎♟︎♟︎♟︎♟︎♟︎♟︎♟︎2\n1♜♞♝♛♚♝♞♜1\n abcdefgh\n\n\n\nWhite, enter your move:\n\n").to_stdout # rubocop:disable Layout/LineLength
    end
  end

  describe 'valid_coordinate_notation_move' do
    it 'returns nil for a valid move' do
      expect(described_class.new.send(:valid_coordinate_notation_move, 'E2-E6')).to be_nil
    end

    it 'raises an error for an invalid move' do
      expect do
        described_class.new.send(:valid_coordinate_notation_move, 'e2e5')
      end.to raise_error(ArgumentError, 'Invalid input, use coordinate notation, for example "A2-A4", "B1-C3", etc.')
    end
  end

  describe 'pick_piece' do
    it 'returns the piece at the given position' do
      expect(described_class.new.send(:pick_piece, 'E2-E4')).to be_instance_of(Pawn)
    end

    it 'raises an error if there is no piece at the given position' do
      expect do
        described_class.new.send(:pick_piece, 'E3-E4')
      end.to raise_error('No piece at that position.')
    end

    it 'raises an error if the piece at the given position is not the current player\'s' do
      expect do
        described_class.new.send(:pick_piece, 'E7-E5')
      end.to raise_error('Not your piece.')
    end
  end
end
