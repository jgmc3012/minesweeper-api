require_relative '../../core'

module V1
  class GamesController < ApplicationController
    include Auth
    before_action :authenticate_user

    rescue_from Exception do |e|
      render json: { error: e.message }, status: :internal_server_error
    end

    rescue_from Core::Exceptions::MinesweeperExpection do |e|
      render json: { error: e.message }, status: :bad_request
    end

    def create
      game_interface = Core::GameI.new
      game_interface.new_game!(width: create_params[:cols],
                              heigth: create_params[:rows],
                              mines: create_params[:mines])
      Game.create!(user_id: Current.user.id, user_board: game_interface.user_board.as_json,
                   mines_board: game_interface.mines_board.as_json, is_over: game_interface.is_over)
      render json: { board: game_interface.render_board, msg: 'Good luck' }, status: :created
    end

    private
    def create_params
      {
        rows: params.require(:rows).to_i,
        cols: params.require(:cols).to_i,
        mines: params.require(:mines).to_i
      }
    end
  end
end