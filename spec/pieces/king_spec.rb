# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/pieces/king'
require_relative '../../lib/chess'

RSpec.describe King do
  describe '#to_s' do
    let(:board) { Chess.new.board }

    it 'returns the correct symbol for a white king' do
      king = described_class.new(board, [7, 4], 'white')
      expect(king.to_s).to eq('♚')
    end

    it 'returns the correct symbol for a black king' do
      king = described_class.new(board, [0, 4], 'black')
      expect(king.to_s).to eq('♔')
    end
  end

  describe '#in_check?' do
    it 'returns true if the king is in check' do
      king = Chess.new(starting_position: '3rk3/8/8/8/3K4/8/8/8 w -').kings['white']
      expect(king.in_check?).to be true
    end

    it 'returns false if the king is not in check' do
      king = Chess.new(starting_position: '4k3/8/8/8/8/8/8/4K3 b -').kings['black']
      expect(king.in_check?).to be false
    end
  end

  describe '#moves' do
    it 'returns the correct moves for a king in the center of the board' do
      king = Chess.new(starting_position: 'k7/8/8/3K4/8/8/8/8 w -').kings['white']
      expect(king.moves).to contain_exactly([2, 2], [2, 3], [2, 4], [3, 2], [3, 4], [4, 2], [4, 3], [4, 4])
    end

    context 'when kings are in the corners' do
      let(:chess) { Chess.new(starting_position: 'k7/8/8/8/8/8/8/7K b -') }

      it 'returns the correct moves for a king in the top left corner' do
        king = chess.kings['black']
        expect(king.moves).to contain_exactly([0, 1], [1, 0], [1, 1])
      end

      it 'returns the correct moves for a king in the bottom right corner' do
        king = chess.kings['white']
        expect(king.moves).to contain_exactly([6, 6], [6, 7], [7, 6])
      end
    end
  end
end
