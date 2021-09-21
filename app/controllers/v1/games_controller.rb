module V1
  class GamesController < ApplicationController

    rescue_from Core::Exceptions::MinesweeperExpection do |e|
      render json: { error: e.message }, status: :bad_request
    end

    def create
      game_interface = Core::GameI.new
      game_interface.new_game(width: create_params[:cols],
                              heigth: create_params[:rows],
                              mines: create_params[:mines])
      render json: { board: game_interface.render_board, msg: 'Good luck' }, status: :created
    end

    def create_params
      {
        rows: params.require(:rows).to_i,
        cols: params.require(:cols).to_i,
        mines: params.require(:mines).to_i
      }
    end
  end
end