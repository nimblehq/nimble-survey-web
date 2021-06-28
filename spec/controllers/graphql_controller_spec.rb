# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  describe 'POST#create' do
    context 'given an authenticated request', auth: :user_token do
      it 'returns success status' do
        post :create, params: { query: sample_query, variables: {} }

        expect(response).to have_http_status(:success)
      end
    end

    context 'given an unauthenticated request' do
      it 'returns unauthorized status' do
        post :create, params: { query: sample_query, variables: {} }

        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns the correct error response format' do
        post :create, params: { query: sample_query, variables: {} }

        response_body = JSON.parse(response.body)
        expect(response_body).to match_json_schema('graphql/create/invalid_token')
      end
    end
  end

  private

  def sample_query
    <<~GRAPHQL
      query {
        profile {
          avatarUrl
          email
          id
        }
      }
    GRAPHQL
  end
end
