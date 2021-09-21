require 'rails_helper'
require_relative '../../../app/core'

RSpec.describe 'Games', type: :request do
  describe 'POST /v1/flags/' do
    context 'toogle flags' do
      before { create_game }
      context 'as mask' do
        params = { x: 1, y: 1, type: Core::Cells::RED_FLAG }
        before { post '/v1/flags/', params: params, headers: user_header }
        it 'returns status code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns the correct message' do
          expect(payload_test[:msg]).to eq('Flag toggled')
        end

        it 'returns the correct flag' do
          expect(payload_test[:board][1][1]).to eq(Core::Cells::RED_FLAG.to_s)
        end
      end

      context 'invalid flag' do
        params = { x: 1, y: 1, type: 'Helo' }
        before { post '/v1/flags/', params: params, headers: user_header }
        it 'returns status code 400' do
          expect(response).to have_http_status(:bad_request)
        end

        it 'returns the correct message' do
          expect(payload_test[:error]).to eq('Invalid type')
        end
      end
    end
  end
end
