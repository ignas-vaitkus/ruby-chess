# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/pieces/pawn'
require_relative '../../lib/chess'

RSpec.describe Pawn do
  describe '#to_s' do
    let(:board) { Chess.new.board }

    it 'returns the correct symbol for a white pawn' do
      pawn = described_class.new(board, [7, 1], 'white')
      expect(pawn.to_s).to eq('♟︎')
    end

    it 'returns the correct symbol for a black pawn' do
      pawn = described_class.new(board, [0, 1], 'black')
      expect(pawn.to_s).to eq('♙')
    end
  end
end
