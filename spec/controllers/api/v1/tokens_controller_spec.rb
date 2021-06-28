# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::TokensController, type: :controller do
  describe 'POST#create' do
    context 'given a valid oauth application' do
      context 'given valid user credentials' do
        it 'returns success status' do
          application = Fabricate(:application)
          Fabricate(:user, email: 'dev@nimblehq.co', password: '12345678')

          params = {
            grant_type: 'password',
            email: 'dev@nimblehq.co',
            password: '12345678'
          }.merge(oauth_application_params(application))

          post :create, params: params

          expect(response).to have_http_status(:success)
        end

        it 'returns an empty response' do
          application = Fabricate(:application)
          Fabricate(:user, email: 'dev@nimblehq.co', password: '12345678')

          params = {
            grant_type: 'password',
            email: 'dev@nimblehq.co',
            password: '12345678'
          }.merge(oauth_application_params(application))

          post :create, params: params

          response_body = JSON.parse(response.body)
          expect(response_body).to match_json_schema('v1/tokens/create/valid')
        end
      end

      context 'given invalid user credentials' do
        it 'returns bad_request status' do
          application = Fabricate(:application)

          params = {
            grant_type: 'password',
            email: 'dev@nimblehq.co',
            password: '12345678'
          }.merge(oauth_application_params(application))

          post :create, params: params

          expect(response).to have_http_status(:bad_request)
        end

        it 'returns an empty response' do
          application = Fabricate(:application)

          params = {
            grant_type: 'password',
            email: 'dev@nimblehq.co',
            password: '12345678'
          }.merge(oauth_application_params(application))

          post :create, params: params

          response_body = JSON.parse(response.body)
          expect(response_body).to match_json_schema('v1/tokens/create/invalid')
        end
      end
    end

    context 'given an invalid oauth application' do
      it 'returns unauthorized status' do
        Fabricate(:user, email: 'dev@nimblehq.co', password: '12345678')

        params = {
          grant_type: 'password',
          email: 'dev@nimblehq.co',
          password: '12345678'
        }

        post :create, params: params

        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        Fabricate(:user, email: 'dev@nimblehq.co', password: '12345678')

        params = {
          grant_type: 'password',
          email: 'dev@nimblehq.co',
          password: '12345678'
        }

        post :create, params: params

        expected_response = {
          errors: [
            {
              code: 'invalid_client',
              detail: 'Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method.',
              source: {
                parameter: 'Doorkeeper::OAuth::Error'
              }
            }
          ]
        }
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
      end
    end
  end

  describe 'POST#revoke' do
    context 'given a valid oauth application' do
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

    context 'given an invalid oauth application' do
      it 'returns forbidden status' do
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
