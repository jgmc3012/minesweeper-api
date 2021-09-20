require 'rails_helper'
require_relative '../../app/core'

describe 'Board' do
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

  describe 'toggle flag' do
    it 'active flag if cell is null' do
      board = Core::Board.new(2, 2, Core::Cells::VOID)
      board.toggle_flag(x: 0, y: 0, flag: Core::Cells::QUESTION_FLAG)
      expect(board[0, 0]).to eq(Core::Cells::QUESTION_FLAG)
    end
    it 'desactive flag if cell is equal to flag' do
      board = Core::Board.new(2, 2, Core::Cells::QUESTION_FLAG)
      board.toggle_flag(x: 0, y: 0, flag: Core::Cells::QUESTION_FLAG)
      expect(board[0, 0]).to eq(Core::Cells::VOID)
    end
    it 'active flag if cell is equal to other flag' do
      board = Core::Board.new(2, 2, Core::Cells::QUESTION_FLAG)
      board.toggle_flag(x: 0, y: 0, flag: Core::Cells::RED_FLAG)
      expect(board[0, 0]).to eq(Core::Cells::RED_FLAG)
    end
  end
end
