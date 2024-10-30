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
end
