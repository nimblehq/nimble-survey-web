# frozen_string_literal: true

module Mutations
  class TestMutation < BaseMutation
    description 'Test mutation'

    argument :name, String, required: true, description: 'Name'

    field :greeting, String, null: false, description: 'Returned greeting'

    def resolve(name:)
      {
        greeting: "Hello #{name}"
      }
    end
  end
end
