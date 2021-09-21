module ApplicationHelper
  def payload_test
    JSON.parse(response.body, symbolize_names: true)
  end

  def user_header
    { Authorization: 'millan' }
  end
end
