# frozen_string_literal: true

require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'

# PieceFactory class that instantiates a new class based on the char passed
class PieceFactory
  def self.create_piece(board, type, position) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength
    color = type == type.upcase ? 'white' : 'black'
    args = [board, position, color]
    case type.downcase
    when 'p'
      Pawn.new(*args)
    when 'r'
      Rook.new(*args)
    when 'n'
      Knight.new(*args)
    when 'b'
      Bishop.new(*args)
    when 'q'
      Queen.new(*args)
    when 'k'
      King.new(*args)
    else
      raise "Unknown piece type: #{type}"
    end
  end
end
