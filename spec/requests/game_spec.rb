require 'rails_helper'

RSpec.describe 'Games', type: :request do
  describe 'POST /v1/games/' do
    context 'create a new game' do
      params_create = {
        rows: 3, cols: 4, mines: 2,
      }
      headers = { Authorization: 'jgmc3012' }
      before { post('/v1/games/', params: params_create, headers: headers) }

      context 'returns status code 201' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end

      context 'returns the board game and message' do
        subject { payload_test }
        it { expect(subject).to include(:board) }
        it { expect(subject).to include(:message) }
      end
    end
  end
end
