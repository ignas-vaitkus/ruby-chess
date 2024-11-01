# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/pieces/bishop'
require_relative '../../lib/chess'

RSpec.describe Bishop do
  describe '#to_s' do
    let(:board) { Chess.new.board }

    it 'returns the correct symbol for a white bishop' do
      bishop = described_class.new(board, [7, 2], 'white')
      expect(bishop.to_s).to eq('♝')
    end

    it 'returns the correct symbol for a black bishop' do
      bishop = described_class.new(board, [0, 2], 'black')
      expect(bishop.to_s).to eq('♗')
    end
  end

  describe '#moves' do
    it 'returns the correct moves for a bishop at the edge of the board' do
      bishop = Chess.new('3bk3/8/8/8/8/8/8/4K3 b').board[0][3]
      expected_moves = [[1, 2], [2, 1], [3, 0], [1, 4], [2, 5], [3, 6], [4, 7]]
      expect(bishop.moves).to match_array(expected_moves)
    end

    it 'returns the correct moves for a bishop in the center of the board' do
      bishop = Chess.new('4k3/8/8/3b4/8/8/8/4K3 b').board[3][3]
      expected_moves = [[0, 0], [1, 1], [2, 2], [4, 4], [5, 5], [6, 6], [7, 7],
                        [0, 6], [1, 5], [2, 4], [4, 2], [5, 1], [6, 0]]
      expect(bishop.moves).to match_array(expected_moves)
    end
  end
end
