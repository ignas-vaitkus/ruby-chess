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

  describe '#check_for_check' do
    it 'returns true if the king is in check' do
      king = Chess.new('3rk3/8/8/8/3K4/8/8/8 w').kings['white']
      expect(king.check_for_check?).to be true
    end

    it 'returns false if the king is not in check' do
      king = Chess.new('4k3/8/8/8/8/8/8/4K3 b').kings['black']
      expect(king.check_for_check?).to be false
    end
  end
end
