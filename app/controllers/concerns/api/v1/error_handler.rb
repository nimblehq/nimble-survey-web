# frozen_string_literal: true

module API
  module V1
    module ErrorHandler
      extend ActiveSupport::Concern

      private

      # Render Error Message in json_api format
      # :reek:LongParameterList { max_params: 5 }
      def render_error(detail:, source: nil, meta: nil, status: :unprocessable_entity, code: nil)
        errors = build_errors(detail: detail, source: source, meta: meta, code: code)

        render json: { errors: errors }, status: status
      end

      # :reek:LongParameterList { max_params: 4 }
      def build_errors(detail:, source: nil, meta: nil, code: nil)
        [
          {
            source: { parameter: source }.compact,
            detail: detail,
            code: code,
            meta: meta
          }.delete_if { |_, value| value.blank? }
        ]
      end
    end
  end
end
