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
    end
  end

  describe 'merge boards' do
    it 'order flags > user > mines'
  end
end
