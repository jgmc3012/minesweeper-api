require 'rails_helper'
require_relative '../../app/core'

describe 'Game' do
  describe 'star a game' do
    describe 'as new game' do
      game = Core::Game.new
      mines = 10
      game.new_game(width: 10, heigth: 10, mines: mines)
      it 'The user board should be hide' do
        expect(game.user_board.all?(Core::Cells::HIDE)).to eq(true)
      end
      it 'Total mines should be indicated' do
        expect(game.mines_board.count(Core::Cells::MINE)).to eq(mines)
      end
      it 'The flag board should be void' do
        expect(game.flags_board.all?(Core::Cells::VOID)).to eq(true)
      end
    end
  end
end
