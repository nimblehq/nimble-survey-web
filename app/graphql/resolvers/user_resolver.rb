# frozen_string_literal: true

module Resolvers
  class UserResolver < BaseResolver
    description 'User profile'

    type Types::UserType, null: false

    def resolve
      context[:current_user]
    end
  end
end
