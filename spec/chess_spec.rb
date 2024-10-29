# frozen_string_literal: true

# require 'minitest/autorun'
require_relative '../lib/chess'

describe Chess do
  describe '#board_to_s' do
    it 'returns populated board' do
      expect(described_class.new.board_to_s).to eql(" abcdefgh\n8rnbqkbnr8\n7pppppppp7\n6■□■□■□■□6\n5□■□■□■□■5\n4■□■□■□■□4\n3□■□■□■□■3\n2PPPPPPPP2\n1RNBQKBNR1\n abcdefgh\n") # rubocop:disable Layout/LineLength
    end
  end
end
