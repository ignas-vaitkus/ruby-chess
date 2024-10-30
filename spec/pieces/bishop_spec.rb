# frozen_string_literal: true

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
end
