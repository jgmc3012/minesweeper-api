require 'rails_helper'

RSpec.describe 'Games', type: :request do
  describe 'POST /v1/games/' do
    context 'create a new game' do
      params_create = {
        rows: 3, cols: 4, mines: 2,
      }
      before { post('/v1/games/', params: params_create, headers: user_header) }

      context 'returns status code 201' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end

      context 'returns the board game and message' do
        subject { payload_test }
        it { expect(subject).to include(:board) }
        it { expect(subject).to include(:msg) }
      end

      context 'user has a new game' do
        user = User.find_by_username('millan')
        it { expect(user.games.count).to eq(1) }
      end
    end
  end
end
