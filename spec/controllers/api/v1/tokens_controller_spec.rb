# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::TokensController, type: :controller do
  describe 'POST#revoke' do
    context 'given a valid oauth application' do
      context 'given a valid access token' do
        it 'returns success status' do
          application = Fabricate(:application)
          Fabricate(:access_token, token: 'access_token', application_id: application.id)

          post :revoke, params: { token: 'access_token' }.merge(oauth_application_params(application))

          expect(response).to have_http_status(:success)
        end

        it 'returns an empty response' do
          application = Fabricate(:application)
          Fabricate(:access_token, token: 'access_token', application_id: application.id)

          post :revoke, params: { token: 'access_token' }.merge(oauth_application_params(application))

          expect(JSON.parse(response.body)).to be_empty
        end
      end
    end

    context 'given an invalid oauth application' do
      context 'given a valid access token' do
        it 'returns success status' do
          Fabricate(:access_token, token: 'access_token', application_id: Fabricate(:application).id)

          post :revoke, params: { token: 'access_token' }

          expect(response).to have_http_status(:forbidden)
        end

        it 'returns an error message' do
          Fabricate(:access_token, token: 'access_token', application_id: Fabricate(:application).id)

          post :revoke, params: { token: 'access_token' }

          expected_response = {
            errors: [
              {
                code: 'unauthorized_client',
                detail: 'You are not authorized to revoke this token'
              }
            ]
          }
          expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
        end
      end
    end
  end
end