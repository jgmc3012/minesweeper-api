module Secured
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
end
