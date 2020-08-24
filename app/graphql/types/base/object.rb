# frozen_string_literal: true

module Types
  module Base
    class Object < GraphQL::Schema::Object
      field_class Types::Base::Field
      connection_type_class Types::Base::Connection
    end
  end
end
