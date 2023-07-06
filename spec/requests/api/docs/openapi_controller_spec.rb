# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::Docs::OpenapiController, type: :request do
  describe 'GET#show' do
    context 'given a request' do
      it 'returns success status' do
        get :show

        expect(response).to have_http_status(:success)
      end
    end
  end
end
