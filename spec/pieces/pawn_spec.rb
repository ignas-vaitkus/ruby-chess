# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/pieces/pawn'
require_relative '../../lib/chess'

RSpec.describe Pawn do
  let(:chess) { Chess.new }

  describe '#to_s' do
    it 'returns the correct symbol for a white pawn' do
      pawn = described_class.new(chess, [7, 1], 'white')
      expect(pawn.to_s).to eq('♟︎')
    end

    it 'returns the correct symbol for a black pawn' do
      pawn = described_class.new(chess, [0, 1], 'black')
      expect(pawn.to_s).to eq('♙')
    end
  end

  describe '#first_move?' do
    it 'returns true for a pawn in its starting position' do
      pawn = described_class.new(chess, [6, 1], 'white')
      expect(pawn.first_move?).to be true
    end

    it 'returns false for a pawn not in its starting position' do
      pawn = described_class.new(chess, [5, 1], 'white')
      expect(pawn.first_move?).to be false
    end
  end

  describe '#front_moves' do
    it 'returns the correct moves for a white pawn in its starting position' do
      pawn = described_class.new(chess, [6, 1], 'white')
      expect(pawn.front_moves).to eq([[5, 1], [4, 1]])
    end

    it 'returns the correct moves for a black pawn in its starting position' do
      pawn = described_class.new(chess, [1, 1], 'black')
      expect(pawn.front_moves).to eq([[2, 1], [3, 1]])
    end

    it 'returns the correct moves for a white pawn that has moved' do
      pawn = described_class.new(chess, [5, 1], 'white')
      expect(pawn.front_moves).to eq([[4, 1]])
    end

    it 'returns the correct moves for a black pawn that has moved' do
      pawn = described_class.new(chess, [2, 1], 'black')
      expect(pawn.front_moves).to eq([[3, 1]])
    end
  end

  describe '#diagonal_moves' do
    it 'returns the correct moves for a white pawn that can take' do
      chess = Chess.new('4k3/8/8/4p3/3P4/8/8/4K3 w')
      pawn = chess.board[4][3]
      expect(pawn.diagonal_moves).to eq([[3, 4]])
    end
  end

  describe '#moves_after_check' do
    it 'returns moves that do not leave the king in check' do
      chess = Chess.new('4k3/4r3/3p4/4P3/8/8/8/4K3 w')
      pawn = chess.board[3][4]
      expect(pawn.moves_after_check).to eq([[2, 4]])
    end

    it 'returns moves that do not leave save the king from check' do
      chess = Chess.new('4k3/8/4r3/3P4/8/8/8/4K3 w')
      pawn = chess.board[3][3]
      expect(pawn.moves_after_check).to eq([[2, 4]])
    end
  end

  describe '#move' do
    it 'raises an error if the move is invalid' do
      pawn = described_class.new(chess, [6, 1], 'white')
      expect { pawn.move([4, 2]) }.to raise_error(ArgumentError, 'Invalid move')
    end

    it 'moves the pawn to the correct position' do
      pawn = described_class.new(chess, [6, 1], 'white')
      pawn.move([5, 1])
      expect(chess.board[5][1]).to eq(pawn)
    end

    it 'sets the pawn position correctly' do
      pawn = described_class.new(chess, [6, 1], 'white')
      pawn.move([5, 1])
      expect(pawn.position).to eq([5, 1])
    end
  end
end
