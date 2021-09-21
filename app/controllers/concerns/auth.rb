module Auth
  private

  def authenticate_user
    headers = request.headers
    username = headers['Authorization']
    if username.nil?
      render json: { error: 'Should sent a username in the \'Authorization\' header' }, status: :unauthorized
      return
    end

    user = User.find_by_username(username)
    if user.nil?
      user = User.create!(username: username)
    end
    Current.user = user
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
