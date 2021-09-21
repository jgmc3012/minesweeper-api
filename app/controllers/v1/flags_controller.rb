module V1
  class FlagsController < ApplicationController
    include Secured
    before_action :authenticate_user
    before_action :current_game

    rescue_from Core::Exceptions::MinesweeperExpection do |e|
      render json: { error: e.message }, status: :bad_request
    end

    def create
      game_interface = Core::GameI.new
      game_interface.resume_game!(Current.game.user_board, Current.game.mines_board, is_over: Current.game.is_over)
      game_interface.exec(**exec_params)
      render json: { board: game_interface.render_board, msg: 'Flag toggled' }, status: :ok
    end

    private
    def exec_params
      {
        x: params.require(:x).to_i,
        y: params.require(:y).to_i,
        type_cell: params.require(:type)
      }
    end

    def current_game
      if Current.user.games
        Current.game = Current.user.games.last
      else
        render json: { error: 'No game found. Please run a new game' }, status: :not_found
      end
    end

    def update_game(game_interface)
      Current.game.update!(
        user_board: game_interface.user_board.as_json,
        mines_board: game_interface.mines_board.as_json,
        is_over: game_interface.is_over
      )
    end
  end
end