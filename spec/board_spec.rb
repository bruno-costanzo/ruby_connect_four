# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'creates a board of 6x7 places' do
      expect(board.content).to eq(Array.new(6) { Array.new(7, '') })
    end
  end

  describe '#player_move' do
    it 'put a chip in the table' do
      chip_place = 2
      player_number = 1
      board.player_move(chip_place, player_number)
      expect(board.content[5][2]).to eq(1)
    end
  end

  describe '#winner?' do
    before do
      allow(board).to receive(:check_columns).and_return(false)
      allow(board).to receive(:check_rows).and_return(false)
      allow(board).to receive(:check_diagonals).and_return(true)
    end


    it 'check if it is a winner in columns, rows and diagonals' do
      expect(board).to receive(:check_rows).once
      expect(board).to receive(:check_columns).once
      expect(board).to receive(:check_diagonals).once
      board_result = board.winner?
      expect(board_result).to be true
    end
  end


  describe '#check_rows' do
    it 'check if there is a winner in the rows' do
      board.check_rows
    end
  end
end
