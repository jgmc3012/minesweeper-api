module V1
  class ExplorerController < ApplicationController
    include Auth
    before_action :authenticate_user
    before_action :current_game

    rescue_from Exception do |e|
      render json: { error: e.message }, status: :internal_server_error
    end

    rescue_from Core::Exceptions::MinesweeperExpection do |e|
      render json: { error: e.message }, status: :bad_request
    end

    def create
      game_interface = Core::GameI.new
      game_interface.resume_game!(Current.game.user_board, Current.game.mines_board, is_over: Current.game.is_over)
      begin
        game_interface.exec(**exec_params, type_cell: Core::Cells::SHOW)
      rescue Core::Exceptions::GameOver => e
        render json: { error: e.message }, status: :bad_request
      else
        if game_interface.is_over
          render json: { board: game_interface.render_board, msg: 'Congratulations. You Win!' }, status: :ok
        else
          render json: { board: game_interface.render_board, msg: 'Congratulations. You do not explode' }, status: :ok
        end
      end
      update_game(game_interface)
    end

    private
    def exec_params
      {
        x: params.require(:x).to_i,
        y: params.require(:y).to_i,
      }
    end
  end
end
