# frozen_string_literal: true

module Types
  class MutationType < Types::Base::Object
    field :test, mutation: Mutations::TestMutation
  end
end
