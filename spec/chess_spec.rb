# frozen_string_literal: true

require 'rspec'
require_relative '../lib/chess'

describe Chess do
  let(:random_position) { '4k3/8/8/8/8/8/7P/4K3' }

  describe 'valid_coordinate_notation_move' do
    it 'returns nil for a valid move' do
      expect(described_class.new.send(:valid_coordinate_notation_move, 'E2-E6')).to be_nil
    end

    it 'raises an error for an invalid move' do
      expect do
        described_class.new.send(:valid_coordinate_notation_move, 'e2e5')
      end.to raise_error(ArgumentError, 'Invalid input, use coordinate notation, for example "A2-A4", "B1-C3", etc.')
    end
  end

  describe 'pick_piece' do
    it 'returns the piece at the given position' do
      expect(described_class.new.send(:pick_piece, [6, 4])).to be_instance_of(Pawn)
    end

    it 'raises an error if there is no piece at the given position' do
      expect do
        described_class.new.send(:pick_piece, [5, 4])
      end.to raise_error(ArgumentError, 'No piece at that position.')
    end

    it 'raises an error if the piece at the given position is not the current player\'s' do
      expect do
        described_class.new.send(:pick_piece, [1, 4])
      end.to raise_error(ArgumentError, 'Not your piece.')
    end
  end
end
