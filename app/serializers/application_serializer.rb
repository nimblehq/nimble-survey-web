# frozen_string_literal: true

class ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  include Lookup
end
