module V1
  class GamesController < ApplicationController
    before_action :authenticate_user

    rescue_from Core::Exceptions::MinesweeperExpection do |e|
      render json: { error: e.message }, status: :bad_request
    end

    def create
      game_interface = Core::GameI.new
      game_interface.new_game(width: create_params[:cols],
                              heigth: create_params[:rows],
                              mines: create_params[:mines])
      Game.create!(user_id: Current.user.id, user_board: game_interface.user_board,
                   mines_board: game_interface.mines_board, is_over: game_interface.is_over)
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

    def authenticate_user
      headers = request.headers
      username = headers['Authorization']
      if username.nil?
        render json: { error: 'Should sent a username in the \'Authorization\' header'}, status: :unauthorized
        return
      end

      user = User.find_by_username(username)
      if user.nil?
          user = User.create!(username: username)
      end
      Current.user = user
    end
  end
end