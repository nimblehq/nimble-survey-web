# frozen_string_literal: true

module Types
  class MutationType < Types::Base::Object
    field :create_response, mutation: Mutations::CreateResponseMutation
  end
end
