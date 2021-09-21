require 'rails_helper'
require_relative '../../../app/core'

RSpec.describe 'Games', type: :request do
  describe 'POST /v1/explore/' do
    context 'explore cells' do
      before { create_game }
      context 'success cell' do
        params = { x: 1, y: 1, type: Core::Cells::RED_FLAG }
        before { post '/v1/explorer/', params: params, headers: user_header }
        it 'returns status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns the correct message' do
          expect(payload_test[:msg]).to eq('Congratulations. You do not explode')
        end
      end
    end
  end
end
