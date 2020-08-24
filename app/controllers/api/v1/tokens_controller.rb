# frozen_string_literal: true

module API
  module V1
    class TokensController < Doorkeeper::TokensController
      include API::V1::Error

      private

      def revocation_error_response
        {
          errors: errors(detail: I18n.t('doorkeeper.errors.messages.revoke.unauthorized'), code: :unauthorized_client)
        }
      end
    end
  end
end
