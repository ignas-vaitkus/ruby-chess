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
end
