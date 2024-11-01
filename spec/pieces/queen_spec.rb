# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/pieces/queen'
require_relative '../../lib/chess'

RSpec.describe Queen do
  describe '#to_s' do
    let(:board) { Chess.new.board }

    it 'returns the correct symbol for a white queen' do
      queen = described_class.new(board, [7, 3], 'white')
      expect(queen.to_s).to eq('♛')
    end

    it 'returns the correct symbol for a black queen' do
      queen = described_class.new(board, [0, 3], 'black')
      expect(queen.to_s).to eq('♕')
    end
  end

  describe '#moves' do
    it 'returns the correct moves for a queen at the edge of the board' do
      queen = Chess.new('3qk3/8/8/8/8/8/8/4k3 b').board[0][3]
      expected_moves = [[0, 0], [0, 1], [0, 2], [1, 3], [2, 3], [3, 3], [4, 3], [5, 3], [6, 3],
                        [7, 3], [1, 2], [2, 1], [3, 0], [1, 4], [2, 5], [3, 6], [4, 7]]
      expect(queen.moves).to match_array(expected_moves)
    end

    it 'returns the correct moves for a queen in the center of the board' do
      queen = Chess.new('4k3/8/8/3q4/8/8/8/4K3 b').board[3][3]
      expected_moves = [[0, 3], [1, 3], [2, 3], [3, 0], [3, 1], [3, 2], [3, 4], [3, 5], [3, 6], [3, 7], [4, 3], [5, 3],
                        [6, 3], [7, 3], [0, 0], [1, 1], [2, 2], [4, 4], [5, 5], [6, 6], [7, 7], [0, 6], [1, 5], [2, 4],
                        [4, 2], [5, 1], [6, 0]]
      expect(queen.moves).to match_array(expected_moves)
    end
  end
end
