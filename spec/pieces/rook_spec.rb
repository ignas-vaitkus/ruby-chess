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
end
