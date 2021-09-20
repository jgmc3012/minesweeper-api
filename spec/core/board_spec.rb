require 'rails_helper'
require_relative '../../app/core/core'

describe 'Board' do
  describe 'cell is null?' do
    it 'should return true if cell is null' do
      board = Core::Board.new(2, 2)
      expect(board.cell_is_null?(0, 0)).to eq(true)
    end
    it 'should return false if cell is not null' do
      board = Core::Board.new(2, 2)
      board[0, 0] = 'X'
      expect(board.cell_is_null?(0, 0)).to eq(false)
    end
  end
end
