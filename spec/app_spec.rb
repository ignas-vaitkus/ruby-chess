# frozen_string_literal: true

# require 'minitest/autorun'
require_relative '../lib/app'

describe App do
  describe '#message' do
    it 'returns "Hello world!"' do
      expect(described_class.new.message).to eql('Hello world!')
    end
  end
end
