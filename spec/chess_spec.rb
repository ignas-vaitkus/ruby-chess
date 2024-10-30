# frozen_string_literal: true

# require 'minitest/autorun'
require_relative '../lib/chess'

describe Chess do
  describe '#board_to_s' do
    it 'returns populated board' do
      expect(described_class.new.send(:board_to_s)).to eql(" abcdefgh\n8♖♘♗♕♔♗♘♖8\n7♙♙♙♙♙♙♙♙7\n6■□■□■□■□6\n5□■□■□■□■5\n4■□■□■□■□4\n3□■□■□■□■3\n2♟︎♟︎♟︎♟︎♟︎♟︎♟︎♟︎2\n1♜♞♝♛♚♝♞♜1\n abcdefgh\n") # rubocop:disable Layout/LineLength
    end
  end
end
