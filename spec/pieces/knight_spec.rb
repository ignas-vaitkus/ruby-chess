# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/pieces/knight'
require_relative '../../lib/chess'

RSpec.describe Knight do
  describe '#to_s' do
    let(:board) { Chess.new.board }

    it 'returns the correct symbol for a white knight' do
      knight = described_class.new(board, [7, 1], 'white')
      expect(knight.to_s).to eq('♞')
    end

    it 'returns the correct symbol for a black knight' do
      knight = described_class.new(board, [0, 1], 'black')
      expect(knight.to_s).to eq('♘')
    end
  end

  describe '#moves' do
    let(:board) { Chess.new.board }

    it 'returns the correct moves for a knight in the center of the board' do
      knight = Chess.new(starting_position: '4k3/8/8/8/4n3/8/8/4K3 b').board[4][4]
      expect(knight.moves).to contain_exactly([6, 3], [6, 5], [5, 6], [3, 6], [2, 5], [2, 3], [3, 2], [5, 2])
    end

    it 'returns the correct moves for a knight in the top-left corner of the board' do
      knight = Chess.new(starting_position: 'N3k3/8/8/8/8/8/8/4K3 w').board[0][0]
      expect(knight.moves).to contain_exactly([1, 2], [2, 1])
    end

    it 'returns the correct moves for a knight in the bottom-right corner of the board' do
      knight = Chess.new(starting_position: '4k3/8/8/8/8/8/8/4K2N w').board[7][7]
      expect(knight.moves).to contain_exactly([5, 6], [6, 5])
    end

    it 'returns the correct moves for a knight in the top-right corner of the board' do
      knight = Chess.new(starting_position: '4k2n/8/8/8/8/8/8/4K3 b').board[0][7]
      expect(knight.moves).to contain_exactly([1, 5], [2, 6])
    end
  end
end
