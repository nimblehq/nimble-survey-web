# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ApplicationController do
  controller do
    def index
      render json: { success: true }
    end
  end

  describe 'Filters' do
    it { is_expected.to use_before_action(:doorkeeper_authorize!) }
  end

  describe 'GET#index' do
    context 'given an authenticated request', auth: :user_token do
      it 'returns 200 status' do
        get :index

        expect(response.status).to eq(200)
      end
    end

    context 'given an unauthenticated request' do
      it 'returns 401 status' do
        get :index

        expect(response.status).to eq(401)
      end
    end
  end
end
