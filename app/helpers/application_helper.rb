module ApplicationHelper
  def payload_test
    JSON.parse(response.body, symbolize_names: true)
  end

  def user_header
    { Authorization: 'millan' }
  end

  def create_game
    user = User.create!(username: 'millan')
    game_interface = Core::GameI.new
    game_interface.new_game!(width: 10, heigth: 10, mines: 10)
    Game.create!(user_id: user.id, user_board: game_interface.user_board.as_json,
      mines_board: game_interface.mines_board.as_json, is_over: false)
  end
end
