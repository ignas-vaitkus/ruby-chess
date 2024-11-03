# frozen_string_literal: true

require 'rspec'
require_relative '../lib/chess'

describe Chess do
  subject(:chess) { described_class.new }

  let(:mock_system) { double('system', call: nil) } # rubocop:disable RSpec/VerifiedDoubles
  let(:mock_exit) { double('exit', call: nil) } # rubocop:disable RSpec/VerifiedDoubles

  describe '#valid_coordinate_notation_move' do
    it 'returns nil for a valid move' do
      expect(chess.send(:valid_coordinate_notation_move, 'E2-E6')).to be_nil
    end

    it 'raises an error for an invalid move' do
      expect do
        chess.send(:valid_coordinate_notation_move, 'e2e5')
      end.to raise_error(ArgumentError, 'Invalid input, use coordinate notation, for example "A2-A4", "B1-C3", etc.')
    end
  end

  describe '#pick_piece' do
    it 'returns the piece at the given position' do
      expect(chess.send(:pick_piece, [6, 4])).to be_instance_of(Pawn)
    end

    it 'raises an error if there is no piece at the given position' do
      expect do
        chess.send(:pick_piece, [5, 4])
      end.to raise_error(ArgumentError, 'No piece at that position.')
    end

    it 'raises an error if the piece at the given position is not the current player\'s' do
      expect do
        chess.send(:pick_piece, [1, 4])
      end.to raise_error(ArgumentError, 'Not your piece.')
    end
  end

  describe '.en_passant_square' do
    let(:chess) { described_class.new(system_caller: mock_system) }

    it 'is set after pawn moves 2 squares' do
      chess.send(:handle_input, 'E2-E4')
      expect(chess.en_passant_square).to contain_exactly(5, 4)
    end

    it 'is set to nil after another piece moves' do
      chess.send(:handle_input, 'E2-E4')
      chess.send(:handle_turn_end)
      chess.send(:handle_input, 'E7-E6')
      expect(chess.en_passant_square).to be_nil
    end

    it 'allows for en passant capture' do
      chess = described_class.new(starting_position: '4k3/3p4/8/4P3/8/8/8/4K3 b -', system_caller: mock_system)
      chess.send(:handle_input, 'D7-D5')
      chess.send(:handle_turn_end)
      chess.send(:handle_input, 'E5-D6')
      expect(chess.board[3][3]).to be_nil
    end
  end

  describe '.castling_rights' do
    let(:chess) { described_class.new(system_caller: mock_system) }

    it 'is KQkq at the start of the game' do
      expect(chess.castling_rights).to eq('KQkq')
    end

    it 'is set to kq after the white king moves' do # rubocop:disable RSpec/ExampleLength
      chess.send(:handle_input, 'E2-E4')
      chess.send(:handle_turn_end)
      chess.send(:handle_input, 'E7-E5')
      chess.send(:handle_turn_end)
      chess.send(:handle_input, 'E1-E2')
      expect(chess.castling_rights).to eq('kq')
    end

    it 'is set to Qkq after the kingside rook moves' do # rubocop:disable RSpec/ExampleLength
      chess.send(:handle_input, 'H2-H4')
      chess.send(:handle_turn_end)
      chess.send(:handle_input, 'H7-H5')
      chess.send(:handle_turn_end)
      chess.send(:handle_input, 'H1-H2')
      expect(chess.castling_rights).to eq('Qkq')
    end

    it 'is set to - after the both kings move' do # rubocop:disable RSpec/ExampleLength
      chess.send(:handle_input, 'E2-E4')
      chess.send(:handle_turn_end)
      chess.send(:handle_input, 'E7-E5')
      chess.send(:handle_turn_end)
      chess.send(:handle_input, 'E1-E2')
      chess.send(:handle_turn_end)
      chess.send(:handle_input, 'E8-E7')
      expect(chess.castling_rights).to eq('-')
    end
  end

  describe '#take_castling_rights' do
    it 'removes castling rights for the given side' do
      chess.send(:take_castling_rights, 'K')
      expect(chess.castling_rights).to eq('Qkq')
    end

    it 'removes castling rights for both sides' do
      chess.send(:take_castling_rights, 'KQ')
      expect(chess.castling_rights).to eq('kq')
    end
  end

  describe '#handle_game_end' do
    it 'ends the game when the king is in checkmate' do # rubocop:disable RSpec/ExampleLength
      chess = described_class.new(starting_position: 'rnbqkbnr/pppp1ppp/8/4p3/2B1P3/5Q2/PPPP1PPP/RNB1K1NR w KQkq',
                                  system_caller: mock_system, exit_caller: mock_exit)
      chess.send(:handle_input, 'F3-F7')
      chess.send(:handle_turn_end)

      expected_output = "\n\n\n\n abcdefgh\n8♖♘♗♕♔♗♘♖8\n7♙♙♙♙□♛♙♙7\n6■□■□■□■□6\n5□■□■♙■□■5\n4■□♝□♟︎□■□4\n3□■□■□■□■3\n2♟︎♟︎♟︎♟︎■♟︎♟︎♟︎2\n1♜♞♝■♚■♞♜1\n abcdefgh\n\n\n\nBlack is in checkmate, game over!\n" # rubocop:disable Layout/LineLength

      expect { chess.send(:handle_game_end) }.to output(expected_output).to_stdout
    end

    it 'ends the game when the king is in stalemate' do # rubocop:disable RSpec/ExampleLength
      chess = described_class.new(starting_position: 'k7/8/8/1Q6/8/8/2R5/1R2K3 w -',
                                  system_caller: mock_system, exit_caller: mock_exit)
      chess.send(:handle_input, 'B5-B6')
      chess.send(:handle_turn_end)

      expected_output = "\n\n\n\n abcdefgh\n8♔□■□■□■□8\n7□■□■□■□■7\n6■♛■□■□■□6\n5□■□■□■□■5\n4■□■□■□■□4\n3□■□■□■□■3\n2■□♜□■□■□2\n1□♜□■♚■□■1\n abcdefgh\n\n\n\nBlack is in stalemate, game over!\n" # rubocop:disable Layout/LineLength

      expect { chess.send(:handle_game_end) }.to output(expected_output).to_stdout
    end
  end
end
