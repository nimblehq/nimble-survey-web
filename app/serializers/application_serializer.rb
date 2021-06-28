# frozen_string_literal: true

class ApplicationSerializer
  include JSONAPI::Serializer
  include Lookup
end
