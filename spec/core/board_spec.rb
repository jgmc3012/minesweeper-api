require 'rails_helper'
require_relative '../../app/core'

describe 'Board' do
  describe 'cell is null?' do
    it 'should return true if cell is null' do
      board = Core::Board.new
      board.mount_new_board(2, 2, Core::Cells::VOID)
      expect(board.cell_is_void?(0, 0)).to eq(true)
    end
    it 'should return false if cell is not null' do
      board = Core::Board.new
      board.mount_new_board(2, 2, Core::Cells::VOID)
      board[0, 0] = 'X'
      expect(board.cell_is_void?(0, 0)).to eq(false)
    end
  end

  describe 'toggle flag' do
    it 'active flag if cell is null' do
      board = Core::Board.new
      board.mount_new_board(2, 2, Core::Cells::VOID)
      board.toggle_flag(x: 0, y: 0, flag: Core::Cells::QUESTION_FLAG)
      expect(board[0, 0]).to eq(Core::Cells::QUESTION_FLAG)
    end
    it 'desactive flag if cell is equal to flag' do
      board = Core::Board.new
      board.mount_new_board(2, 2, Core::Cells::QUESTION_FLAG)
      board.toggle_flag(x: 0, y: 0, flag: Core::Cells::QUESTION_FLAG)
      expect(board[0, 0]).to eq(Core::Cells::VOID)
    end
    it 'active flag if cell is equal to other flag' do
      board = Core::Board.new
      board.mount_new_board(2, 2, Core::Cells::QUESTION_FLAG)
      board.toggle_flag(x: 0, y: 0, flag: Core::Cells::RED_FLAG)
      expect(board[0, 0]).to eq(Core::Cells::RED_FLAG)
    end
  end

  describe 'mount a board' do
    data_board = [
      %w[1 R 1 H H],
      %w[1 1 1 H H],
      %w[H H 2 H H],
      %w[H H H H H],
      %w[Q H H 4 H]
    ]
    board = Core::Board.new
    board.mount_new_board(5, 5)
    board.mount_board(data_board)

    it 'number cell' do
      expect(board[0, 0]).to eq(1)
      expect(board[2, 2]).to eq(2)
    end

    it 'red flag cell' do
      expect(board[1, 0]).to eq(Core::Cells::RED_FLAG)
    end

    it 'question flag cell' do
      expect(board[0, 4]).to eq(Core::Cells::QUESTION_FLAG)
    end

    it 'hide cell' do
      expect(board[4, 0]).to eq(Core::Cells::HIDE)
    end

  end
end
