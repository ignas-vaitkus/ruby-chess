# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/pieces/rook'
require_relative '../../lib/chess'

RSpec.describe Rook do
  describe '#to_s' do
    let(:board) { Chess.new.board }

    it 'returns the correct symbol for a white rook' do
      rook = described_class.new(board, [7, 3], 'white')
      expect(rook.to_s).to eq('♜')
    end

    it 'returns the correct symbol for a black rook' do
      rook = described_class.new(board, [0, 3], 'black')
      expect(rook.to_s).to eq('♖')
    end
  end

  describe '#moves' do
    it 'returns the correct moves for a rook at the edge of the board' do
      rook = Chess.new(starting_position: '3rk3/8/8/8/8/8/8/4k3 b -').board[0][3]
      expected_moves = [[0, 0], [0, 1], [0, 2], [1, 3], [2, 3], [3, 3], [4, 3], [5, 3], [6, 3], [7, 3]]
      expect(rook.moves).to match_array(expected_moves)
    end

    it 'returns the correct moves for a rook in the center of the board' do
      rook = Chess.new(starting_position: '4k3/8/8/3r4/8/8/8/4K3 b -').board[3][3]
      expected_moves = [[0, 3], [1, 3], [2, 3], [3, 0], [3, 1], [3, 2], [3, 4],
                        [3, 5], [3, 6], [3, 7], [4, 3], [5, 3], [6, 3], [7, 3]]
      expect(rook.moves).to match_array(expected_moves)
    end
  end
end
