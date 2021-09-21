require 'rails_helper'
require_relative '../../app/core'

describe 'Game' do
  describe 'star a game' do
    describe 'as new game' do
      game = Core::GameI.new
      mines = 10
      game.new_game!(width: 10, heigth: 10, mines: mines)
      it 'The user board should be hide' do
        expect(game.user_board.all?(Core::Cells::HIDE)).to eq(true)
      end
      it 'Total mines should be indicated' do
        expect(game.mines_board.count(Core::Cells::MINE)).to eq(mines)
      end
    end
  end

  describe 'merge boards' do
    user_board = [
      %w[H H H H H],
      %w[H H R H H],
      %w[Q H H H H],
      %w[H Q H H H],
      %w[S H H S H]
    ]
    mine_board = [
      %w[H H H 1 0],
      %w[M H M 1 0],
      %w[M H 2 1 0],
      %w[H M 1 0 0],
      %w[1 H 1 0 0]
    ]
    it 'the game yep dont is over' do
      expected_board = [
        %w[H H H 1 0],
        %w[H H R 1 0],
        %w[Q H 2 1 0],
        %w[H Q 1 0 0],
        %w[1 H 1 0 0]
      ]
      game = Core::GameI.new
      game.resume_game!(user_board, mine_board)
      expect(game.render_board).to eq(expected_board)
    end
    it 'the game is over' do
      expected_board = [
        %w[H H H 1 0],
        %w[M H M 1 0],
        %w[M H 2 1 0],
        %w[H M 1 0 0],
        %w[1 H 1 0 0]
      ]
      game = Core::GameI.new
      game.resume_game!(user_board, mine_board, is_over: true)
      expect(game.render_board).to eq(expected_board)
    end

  end
end
