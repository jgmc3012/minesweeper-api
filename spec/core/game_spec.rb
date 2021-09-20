require 'rails_helper'
require_relative '../../app/core'

describe 'Game' do
  describe 'cell is null?' do
    it 'should return true if cell is null' do
      board = Core::Board.new(2, 2, Core::Cells::VOID)
      expect(board.cell_is_void?(0, 0)).to eq(true)
    end
    it 'should return false if cell is not null' do
      board = Core::Board.new(2, 2, Core::Cells::VOID)
      board[0, 0] = 'X'
      expect(board.cell_is_void?(0, 0)).to eq(false)
    end
  end
end
