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
      end.to output(" abcdefgh\n8♖♘♗♕♔♗♘♖8\n7♙♙♙♙♙♙♙♙7\n6■□■□■□■□6\n5□■□■□■□■5\n4■□■□■□■□4\n3□■□■□■□■3\n2♟︎♟︎♟︎♟︎♟︎♟︎♟︎♟︎2\n1♜♞♝♛♚♝♞♜1\n abcdefgh\n\n\n\nWhite, enter your move:\n\n").to_stdout
    end
  end
end
