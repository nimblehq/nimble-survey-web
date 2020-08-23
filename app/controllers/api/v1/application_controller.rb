# frozen_string_literal: true

module API
  module V1
    class ApplicationController < ActionController::API
      include API::V1::ErrorHandler

      before_action :doorkeeper_authorize!

      private

      def current_user
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end

      # :reek:FeatureEnvy
      def doorkeeper_unauthorized_render_options(error: nil)
        return unless error

        {
          json: {
            errors: build_errors(detail: error.description, source: error.state, code: error.name)
          }
        }
      end

      def doorkeeper_unauthorized_render_options(error: nil)
        return unless error

        {
          json: {
            errors: [
              {
                source: error.state,
                detail: error.description,
                code: error.name
              }.compact
            ]
          }
        }
      end
    end
  end
end
