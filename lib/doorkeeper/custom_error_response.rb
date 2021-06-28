# frozen_string_literal: true

module Doorkeeper
  module CustomErrorResponse
    def body
      {
        errors: [
          {
            source: { parameter: @error.class.name },
            detail: description,
            code: name
          }.compact
        ]
      }
    end
  end
end
