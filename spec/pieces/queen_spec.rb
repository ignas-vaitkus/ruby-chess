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
end
